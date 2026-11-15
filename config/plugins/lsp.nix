{pkgs, ...}: {
  # lua_ls needs vim's own Lua API to stop reporting every `vim.*` as undefined.
  plugins.lazydev.enable = true;

  plugins.lsp = {
    enable = true;

    # nixd replaces nil_ls: one Nix server, and it understands flakes. Its
    # `options.nixpkgs.expr` is deliberately unset — that form needs a NIX_PATH
    # a standalone nvim does not have.
    servers = {
      nixd = {
        enable = true;
        settings.nixd.formatting.command = "${pkgs.alejandra}/bin/alejandra";
      };
      lua_ls.enable = true;
    };

    keymaps.diagnostic."<leader>q" = {
      mode = "n";
      action = "setloclist";
      desc = "Diagnostics to quickfix";
    };
  };
}
