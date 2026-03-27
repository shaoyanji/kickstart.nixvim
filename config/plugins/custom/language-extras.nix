{
  pkgs,
  ...
}:
{
  plugins = {
    nix-develop.enable = true;
    otter.enable = true;
    lsp.servers = {
      gopls.enable = true;
      nixd = {
        enable = true;
        settings = {
          nixd = {
            formatting.command = "${pkgs.alejandra}/bin/alejandra";
            options.nixpkgs.expr = "import <nixpkgs> {}";
          };
        };
      };
    };
  };
}
