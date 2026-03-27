{ ... }: {
  plugins.obsidian = {
    enable = true;
    settings = {
      legacy_commands = true;
      completion.min_chars = 2;
      new_notes_location = "current_dir";
      workspaces = [
        {
          name = "work";
          path = "~/vaults/work";
        }
        {
          name = "startup";
          path = "~/vaults/personal";
        }
      ];
    };
  };
}
