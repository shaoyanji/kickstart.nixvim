{pkgs, ...}: {
  extraPackages = [pkgs.stylua];

  plugins.conform-nvim = {
    enable = true;

    settings = {
      notify_on_error = false;
      # C and C++ have no single style; everything else falls back to its LSP.
      format_on_save = ''
        function(bufnr)
          if vim.bo[bufnr].filetype == "c" or vim.bo[bufnr].filetype == "cpp" then
            return nil
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end
      '';
      formatters_by_ft.lua = ["stylua"];
    };
  };

  keymaps = [
    {
      mode = "";
      key = "<leader>f";
      action.__raw = ''
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end
      '';
      options.desc = "[F]ormat buffer";
    }
  ];
}
