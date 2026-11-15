{
  plugins = {
    which-key = {
      enable = true;
      settings = {
        delay = 0;
        spec = [
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
          }
        ];
      };
    };

    mini = {
      enable = true;
      modules.statusline.use_icons.__raw = "vim.g.have_nerd_font";
    };

    mini-pairs.enable = true;
    mini-surround.enable = true;

    gitsigns.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "]c";
      action.__raw = "function() require('gitsigns').nav_hunk 'next' end";
      options.desc = "Next git hunk";
    }
    {
      mode = "n";
      key = "[c";
      action.__raw = "function() require('gitsigns').nav_hunk 'prev' end";
      options.desc = "Previous git hunk";
    }
  ];
}
