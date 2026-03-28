{
  plugins.neogit = {
    enable = true;

    settings = {
      integrations = {
        diffview = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>Neogit<CR>";
      options = {
        desc = "[G]it status";
      };
    }
  ];
}
