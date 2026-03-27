{
  plugins.toggleterm = {
    enable = true;

    settings = {
      direction = "horizontal";
      size = 12;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<CR>";
      options = {
        desc = "[T]oggle [T]erminal";
      };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options = {
        desc = "[T]oggle [F]loating terminal";
      };
    }
  ];
}
