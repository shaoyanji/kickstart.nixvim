{
  plugins.telescope = {
    enable = true;

    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };

    keymaps = {
      "<leader>sf" = {
        mode = "n";
        action = "find_files";
        options.desc = "[S]earch [F]iles";
      };
      "<leader>sg" = {
        mode = "n";
        action = "live_grep";
        options.desc = "[S]earch by [G]rep";
      };
      "<leader>sd" = {
        mode = "n";
        action = "diagnostics";
        options.desc = "[S]earch [D]iagnostics";
      };
      "<leader>sk" = {
        mode = "n";
        action = "keymaps";
        options.desc = "[S]earch [K]eymaps";
      };
      "<leader>sh" = {
        mode = "n";
        action = "help_tags";
        options.desc = "[S]earch [H]elp";
      };
      "<leader><leader>" = {
        mode = "n";
        action = "buffers";
        options.desc = "Find existing buffers";
      };
    };
  };
}
