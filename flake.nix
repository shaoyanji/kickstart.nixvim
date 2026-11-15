{
  description = "A minimal Neovim configuration built on nixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        module = import ./nixvim.nix {};
        nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
          inherit pkgs;
          inherit module;
        };
      in {
        packages.default = nvim;
        apps.default = {
          type = "app";
          program = "${nvim}/bin/nvim";
        };

        # `nix flake check` builds this and starts the editor headless; CI runs
        # the same command (.github/workflows/ci.yml).
        checks.default =
          nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule {inherit pkgs module;};

        formatter = pkgs.alejandra;
      };

      flake = {
        nixosModules.default = {
          imports = [inputs.nixvim.nixosModules.nixvim];
          programs.nixvim = import ./nixvim.nix {};
        };

        homeManagerModules.default = {
          imports = [inputs.nixvim.homeModules.nixvim];
          programs.nixvim = import ./nixvim.nix {};
        };

        darwinModules.default = {
          imports = [inputs.nixvim.darwinModules.nixvim];
          programs.nixvim = import ./nixvim.nix {};
        };
      };
    };
}
