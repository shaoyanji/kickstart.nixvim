{
  # Jump/search navigation with labels
  # https://nix-community.github.io/nixvim/plugins/flash/index.html
  plugins.flash.enable = true;

  keymaps = [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>sj";
      action.__raw = ''
        function()
          require('flash').jump()
        end
      '';
      options = {
        desc = "[S]earch [J]ump";
      };
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>sJ";
      action.__raw = ''
        function()
          require('flash').treesitter()
        end
      '';
      options = {
        desc = "[S]earch treesitter [J]ump";
      };
    }
  ];
}
