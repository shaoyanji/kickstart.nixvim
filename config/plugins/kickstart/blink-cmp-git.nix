{
  plugins.blink-cmp-git.enable = true;

  plugins.blink-cmp.settings.sources = {
    per_filetype.gitcommit = [
      "lsp"
      "path"
      "snippets"
      "lazydev"
      "git"
    ];

    providers.git = {
      module = "blink-cmp-git";
      name = "Git";
      score_offset = 90;
    };
  };
}
