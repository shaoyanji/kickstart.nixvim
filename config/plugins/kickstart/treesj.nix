{
  # Split and join syntax-aware code blocks
  # https://nix-community.github.io/nixvim/plugins/treesj/index.html
  plugins.treesj = {
    enable = true;
    settings = {
      use_default_keymaps = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "gS";
      action.__raw = ''
        function()
          require('treesj').split()
        end
      '';
      options = {
        desc = "Split code block";
      };
    }
    {
      mode = "n";
      key = "gJ";
      action.__raw = ''
        function()
          require('treesj').join()
        end
      '';
      options = {
        desc = "Join code block";
      };
    }
  ];
}
