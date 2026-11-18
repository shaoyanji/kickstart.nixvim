# Ghost text from a FIM endpoint, or from a chat model when the route has no
# infill.
#
# The FIM shape is `/completions` with `suffix` filled in — a llama.cpp `--jinja`
# build, this fleet's Strata MoE on eisen, or a hosted FIM API. A hosted
# provider that speaks the same shape needs no code path of its own, only three
# values, so they are variables with a local default rather than a second
# backend. With no server reachable the plugin fails one request and the editor
# behaves as if it were absent.
#
# Local (the default, no account, no token):
#
#   MINUET_ENDPOINT   http://eisen.lan/v1/completions
#   MINUET_MODEL      qwen3.6-35b-a3b
#   MINUET_API_KEY_NAME  TERM   (a local server ignores the header)
#
# Hosted, e.g. DeepSeek's beta FIM (`prompt` + `suffix`, 4K max, billed per
# call like chat — 4K tokens is the ceiling, not a target):
#
#   vim.env.MINUET_ENDPOINT = "https://api.deepseek.com/beta/completions"
#   vim.env.MINUET_MODEL = "deepseek-flash"
#   vim.env.MINUET_API_KEY_NAME = "DEEPSEEK_API_KEY"
#
# Infron (llm.onerouter.pro) is the second path, and it has no infill endpoint:
# `/v1/completions` is a 404 upstream for deepseek/deepseek-v4-flash-0731:free,
# and the qwen free id answers a plain prompt there but rejects every `suffix`
# with "suffix is not currently supported" (measured 2026-11-18). What the route
# does serve is `/v1/chat/completions`, so minuet's `openai_compatible` provider
# carries the text before the cursor and the text after it in one chat turn.
# That is not infill — the model reads the following code as prompt text rather
# than through a suffix channel, so a suggestion can repeat what is already
# below the cursor — but it is the only ghost text this route can produce. Both
# ids it names are `:free`, which the router bills at zero: the account balance
# is not touched. A chat completion shaped like the prompt below returned
# `return a + b`, the line a FIM endpoint would have produced.
#
# Which provider runs is decided once, at setup: MINUET_PROVIDER wins if set,
# otherwise the hosted chat route when INFRON_API_KEY is in the environment,
# otherwise the local FIM. Exporting the key is therefore the whole switch, and
# an editor on a machine without it never calls the network.
#
# The key name is indirection on purpose: minuet resolves a variable name
# (`get_api_key` does `vim.env[name]`), so the secret never lands in this file or
# in a store path, and exporting the variable is the whole switch.
#
# Per machine, set them without touching this file:
#
#   programs.nixvim.extraConfigLuaPre = ''
#     vim.env.MINUET_ENDPOINT = "https://eisen.cloudforest-kardashev.ts.net/v1/completions"
#     vim.env.MINUET_MODEL = "qwen3.6-35b-a3b"
#   ''
{lib, ...}: {
  plugins.minuet = {
    enable = true;

    settings = {
      provider = lib.mkLuaInline ''
        (function()
          if (vim.env.MINUET_PROVIDER or "") ~= "" then return vim.env.MINUET_PROVIDER end
          if (vim.env.INFRON_API_KEY or "") ~= "" then return "openai_compatible" end
          return "openai_fim_compatible"
        end)()
      '';

      # One candidate per trigger. The default is 3, and on a CPU-bound host or
      # a billed endpoint that is three forward passes per pause for one line of
      # ghost text; cycling candidates is what `<A-]>` is for.
      n_completions = 1;

      # A hosted round trip is slower than a request to a machine on the LAN; the
      # plugin's default gives up while the answer is still in flight.
      request_timeout = 6;

      provider_options = {
        openai_fim_compatible = {
          # A variable name, not a key: a local server ignores the header and the
          # client only requires that the variable exists.
          api_key = lib.mkLuaInline "vim.env.MINUET_API_KEY_NAME or 'TERM'";
          name = "fim";
          model = lib.mkLuaInline "vim.env.MINUET_MODEL or 'qwen3.6-35b-a3b'";
          end_point = lib.mkLuaInline "vim.env.MINUET_ENDPOINT or 'http://eisen.lan/v1/completions'";
          stream = true;
          optional = {
            # Ghost text is worth about one screen line: past that the operator is
            # reading a diff, not accepting a completion.
            max_tokens = 128;
            temperature = 0.2;
          };
        };

        openai_compatible = {
          # `name` is the label minuet prints in its notifications, not a model.
          name = "infron";
          api_key = lib.mkLuaInline "vim.env.MINUET_CHAT_API_KEY_NAME or 'INFRON_API_KEY'";
          model = lib.mkLuaInline "vim.env.MINUET_CHAT_MODEL or 'deepseek/deepseek-v4-flash-0731:free'";
          end_point = lib.mkLuaInline "vim.env.MINUET_CHAT_ENDPOINT or 'https://llm.onerouter.pro/v1/chat/completions'";
          stream = true;
          optional = {
            max_tokens = 128;
            temperature = 0.2;
          };
        };
      };

      virtualtext = {
        enabled = true;
        # FIM costs a forward pass on a CPU-bound host, so the trigger list is
        # the filetypes this config actually edits rather than "*".
        auto_trigger_ft = [
          "nix"
          "lua"
          "python"
          "rust"
          "go"
          "sh"
          "typescript"
          "javascript"
          "c"
          "cpp"
          "yaml"
          "json"
          "markdown"
        ];
        keymap = {
          accept = "<A-a>";
          accept_line = "<A-l>";
          next = "<A-]>";
          prev = "<A-[>";
        };
      };
    };
  };
}
