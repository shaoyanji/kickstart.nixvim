{
  plugins.diffview = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>DiffviewOpen<CR>";
      options = {
        desc = "[G]it [D]iff view";
      };
    }
    {
      mode = "n";
      key = "<leader>gH";
      action = "<cmd>DiffviewFileHistory %<CR>";
      options = {
        desc = "[G]it file [H]istory";
      };
    }
  ];
}
