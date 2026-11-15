# Local-model completion: ghost text from an OpenAI-compatible FIM endpoint.
#
# The target is any server that answers `/v1/completions` with `suffix` filled
# in — a llama.cpp `--jinja` build, or this fleet's Strata MoE on eisen. Nothing
# here names a cloud provider, holds a token, or needs a login: with no server
# reachable the plugin fails one request and the editor behaves as if it were
# absent.
#
# Per machine, override without touching this file:
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

      provider_options.openai_fim_compatible = {
        # A local server ignores the header; the client requires it.
        api_key = "TERM";
        name = "local";
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
