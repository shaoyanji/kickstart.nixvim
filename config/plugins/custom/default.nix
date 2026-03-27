{
pkgs,
  lib,
  ...
}: {
  imports = [
    ./ai.nix
    ./writing.nix
    ./language-extras.nix
  ];
  extraPackages = with pkgs; [
    markdownlint-cli
  ];
  plugins = {
    # cmp-tabnine.enable = true;
    cloak.enable = true;
    cloak.settings = {
      cloak_character = "*";
      enabled = true;
      highlight_group = "Comment";
      patterns = [
        {
          cloak_pattern = "=.+";
          file_pattern = [
            ".env*"
          ];
        }
      ];
    };
  };

  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "tabnine"
  #   ];
}
