# Ghost text from an OpenAI-compatible FIM endpoint.
#
# The shape is `/completions` with `suffix` filled in — a llama.cpp `--jinja`
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
      provider = "openai_fim_compatible";

      # One candidate per trigger. The default is 3, and on a CPU-bound host or
      # a billed endpoint that is three forward passes per pause for one line of
      # ghost text; cycling candidates is what `<A-]>` is for.
      n_completions = 1;

      provider_options.openai_fim_compatible = {
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
