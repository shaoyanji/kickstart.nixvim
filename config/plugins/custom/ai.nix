{
  pkgs,
  ...
}:
{
  plugins.supermaven = {
    enable = true;
    settings = {
      keymaps = {
        accept_suggestion = "<Tab>";
        clear_suggestions = "<C-]>";
        accept_word = "<C-j>";
      };
      ignore_filetypes = [ "cpp" ];
      color = {
        suggestion_color = "#ffffff";
        cterm = 244;
      };
      log_level = "info";
      disable_inline_completion = false;
      disable_keymaps = false;
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    supermaven-nvim
  ];

  extraConfigLuaPost = ''
    if vim.fn.exists(":Supermaven") == 0 and vim.fn.exists(":SupermavenStatus") == 2 then
      vim.api.nvim_create_user_command("Supermaven", function()
        vim.cmd("SupermavenStatus")
      end, {})
    end
  '';
}
