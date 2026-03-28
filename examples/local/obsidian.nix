{
  # Example local-only module for Obsidian.
  # Import this from your Home Manager or host-local Nixvim module, not from the shared base.
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
          name = "personal";
          path = "~/vaults/personal";
        }
      ];
    };
  };
}
