# Machine-local, taste-local additions. The AI editing surface lands beside
# cloak and typst rather than inside a plugin module: everything else here is
# the shape of the editor, and these are this machine's extensions to it.
{pkgs, ...}: {
  imports = [./ai.nix];

  extraPackages = [pkgs.markdownlint-cli];

  plugins = {
    # Mask values in dotenv files.
    cloak = {
      enable = true;
      settings = {
        cloak_character = "*";
        enabled = true;
        highlight_group = "Comment";
        patterns = [
          {
            cloak_pattern = "=.+";
            file_pattern = [".env*"];
          }
        ];
      };
    };

    typst-vim.enable = true;
    typst-preview.enable = true;
  };
}
