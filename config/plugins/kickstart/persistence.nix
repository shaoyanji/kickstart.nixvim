{
  plugins.persistence = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>Sr";
      action.__raw = ''
        function()
          require("persistence").load()
        end
      '';
      options = {
        desc = "[S]ession [R]estore";
      };
    }
    {
      mode = "n";
      key = "<leader>Sl";
      action.__raw = ''
        function()
          require("persistence").load({ last = true })
        end
      '';
      options = {
        desc = "[S]ession [L]ast";
      };
    }
  ];
}
