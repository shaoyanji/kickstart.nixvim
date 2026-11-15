# The editor, in one file: what is imported, then the options, keymaps and
# diagnostics every buffer gets. Anything a single plugin owns lives in
# `config/plugins/`; anything personal lives in `config/plugins/custom/`.
{...}: {
  imports = [
    ./config/plugins/lsp.nix
    ./config/plugins/cmp.nix
    ./config/plugins/treesitter.nix
    ./config/plugins/telescope.nix
    ./config/plugins/conform.nix
    ./config/plugins/ui.nix
    ./config/plugins/custom
  ];

  config = {
    # A pinned nixpkgs is not a released one; the mismatch is expected here.
    version.enableNixpkgsReleaseCheck = false;

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };

    clipboard.register = "unnamedplus";

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
      inccommand = "split";
      cursorline = true;
      scrolloff = 10;
      confirm = true;
      hlsearch = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options.desc = "Focus the left window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options.desc = "Focus the right window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options.desc = "Focus the lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options.desc = "Focus the upper window";
      }
    ];

    autoCmd = [
      {
        event = ["TextYankPost"];
        desc = "Highlight when yanking";
        callback.__raw = ''
          function()
            vim.hl.on_yank()
          end
        '';
      }
    ];

    # Neovim >= 0.11 carries the LSP defaults (`K`, `grn`, `gra`, `grr`, `gri`,
    # `gO`, `<C-s>`), so there is no keymap block for them here.
    diagnostic.settings = {
      severity_sort = true;
      float.border = "rounded";
      underline.severity.__raw = "vim.diagnostic.severity.ERROR";
      virtual_text = {
        source = "if_many";
        spacing = 2;
      };
    };

    plugins = {
      web-devicons.enable = true;
      guess-indent.enable = true;
    };
  };
}
