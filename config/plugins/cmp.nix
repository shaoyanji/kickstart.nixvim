{
  plugins.luasnip.enable = true;

  plugins.blink-cmp = {
    enable = true;

    settings = {
      keymap.preset = "default";
      appearance.nerd_font_variant = "mono";
      # The Rust matcher downloads a prebuilt binary at runtime; the Lua one is
      # the reason this config has no network dependency after activation.
      fuzzy.implementation = "lua";
      signature.enabled = true;
      snippets.preset = "luasnip";
      sources.default = [
        "lsp"
        "path"
        "snippets"
      ];
    };
  };
}
