{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;

    indent.enable = true;

    # Grammars come from nixpkgs, never from `:TSInstall`.
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      diff
      gitcommit
      gitignore
      json
      lua
      markdown
      markdown_inline
      nix
      query
      regex
      rust
      toml
      vim
      vimdoc
      yaml
    ];

    settings.highlight.enable = true;
  };
}
