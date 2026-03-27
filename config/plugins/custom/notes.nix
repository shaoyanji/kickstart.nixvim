{ ... }: {
  # User-local module for Obsidian. This is intentionally not imported by the
  # shared base because the workspace paths are personal-machine specific.
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
