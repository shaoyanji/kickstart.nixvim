{
  # Cohesive QoL suite (folke) — consolidates several single-purpose plugins
  # with negligible startup cost and a smaller closure:
  #   indent-blankline.nvim -> snacks.indent
  #   dressing.nvim         -> snacks.input / snacks.select
  #   vim-illuminate        -> snacks.words
  # https://nix-community.github.io/nixvim/plugins/snacks/index.html
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile = {
        enabled = true;
      };
      bufdelete = {
        enabled = true;
      };
      dashboard = {
        enabled = true;
      };
      indent = {
        enabled = true;
      };
      input = {
        enabled = true;
      };
      notifier = {
        enabled = true;
        timeout = 3000;
      };
      quickfile = {
        enabled = true;
      };
      scratch = {
        enabled = true;
      };
      statuscolumn = {
        enabled = true;
      };
      words = {
        enabled = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options.desc = "Delete Buffer (Snacks)";
    }
    {
      mode = "n";
      key = "<leader>.";
      action.__raw = "function() Snacks.scratch() end";
      options.desc = "Toggle Scratch Buffer (Snacks)";
    }
  ];
}
