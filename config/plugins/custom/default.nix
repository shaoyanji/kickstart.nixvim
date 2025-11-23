{
  lib,
  pkgs,
  ...
}: {
  plugins.supermaven = {
    enable = true;
    settings = {
      keymaps = {
        accept_suggestion = "<Tab>";
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
  plugins.obsidian.enable = true;
  plugins.obsidian.settings = {
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
  extraPlugins = with pkgs.vimPlugins; [
  ];
  plugins.lsp = {
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
}
