{
  lib,
  pkgs,
  ...
}: {
  plugins = {
    typst-vim.enable = true;
    typst-preview.enable = true;
    cmp-tabnine.enable = true;
    cloak.enable = true;
    cloak.settings = {
      cloak_character = "*";
      enabled = true;
      highlight_group = "Comment";
      patterns = [
        {
          cloak_pattern = "=.+";
          file_pattern = [
            ".env*"
          ];
        }
      ];
    };
    nix-develop.enable = true;
    otter.enable = true;
    supermaven = {
      enable = true;
      settings = {
        keymaps = {
          accept_suggestion = "<C-CR>";
          clear_suggestions = "<C-]>";
          accept_word = "<C-j>";
        };
        ignore_filetypes = ["cpp"];
        color = {
          suggestion_color = "#ffffff";
          cterm = 244;
        };
        log_level = "info";
        disable_inline_completion = false;
        disable_keymaps = false;
        condition = lib.nixvim.mkRaw ''
          function()
            return false
          end
        '';
      };
    };
    obsidian.enable = true;
    obsidian.settings = {
      legacy_commands = false;
      completion = {
        min_chars = 2;
      };
      new_notes_location = "current_dir";
      workspaces = [
        {
          name = "work";
          path = "~/vaults/work";
        }
        {
          name = "startup";
          path = "~/vaults/personal";
        }
      ];
    };
    lsp = {
      servers = {
        gopls.enable = true;
        nixd = {
          enable = true;
          settings = {
            nixd = {
              formatting = {
                command = "${pkgs.alejandra}/bin/alejandra";
              };
              options = {
                nixpkgs = {
                  expr = "import <nixpkgs> {}";
                };
              };
            };
          };
        };
      };
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
  ];
}
