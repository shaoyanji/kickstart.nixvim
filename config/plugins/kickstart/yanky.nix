{
  # Better yank history with optional Telescope picker integration
  # https://nix-community.github.io/nixvim/plugins/yanky/index.html
  plugins.yanky = {
    enable = true;
    enableTelescope = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>sy";
      action = "<cmd>Telescope yank_history<CR>";
      options = {
        desc = "[S]earch [Y]ank history";
      };
    }
    {
      mode = "n";
      key = "]y";
      action.__raw = ''
        function()
          require('yanky').cycle(1)
        end
      '';
      options = {
        desc = "Cycle forward through yank history";
      };
    }
    {
      mode = "n";
      key = "[y";
      action.__raw = ''
        function()
          require('yanky').cycle(-1)
        end
      '';
      options = {
        desc = "Cycle backward through yank history";
      };
    }
  ];
}
