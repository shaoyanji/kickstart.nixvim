# Machine-local, taste-local additions. This is the seam where an editing
# surface driven by a local model will land; nothing else in the config should
# need to move for it.
{pkgs, ...}: {
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
