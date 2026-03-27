{
  plugins.trouble = {
    enable = true;

    settings = {
      focus = false;
      follow = true;
      auto_preview = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<CR>";
      options = {
        desc = "Trouble: diagnostics";
      };
    }
    {
      mode = "n";
      key = "<leader>xr";
      action = "<cmd>Trouble lsp_references toggle focus=false<CR>";
      options = {
        desc = "Trouble: references";
      };
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>Trouble qflist toggle<CR>";
      options = {
        desc = "Trouble: quickfix";
      };
    }
    {
      mode = "n";
      key = "<leader>xl";
      action = "<cmd>Trouble loclist toggle<CR>";
      options = {
        desc = "Trouble: location list";
      };
    }
  ];
}
