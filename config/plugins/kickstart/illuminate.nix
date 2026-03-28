{
  # Conservative symbol reference highlighting
  # https://nix-community.github.io/nixvim/plugins/illuminate/index.html
  plugins.illuminate = {
    enable = true;

    settings = {
      delay = 200;
      filetypes_denylist = [
        "dirbuf"
        "fugitive"
      ];
      min_count_to_highlight = 2;
      under_cursor = false;
    };
  };
}
