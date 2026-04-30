{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.zed-editor = {
    enable = true;
    enableMcpIntegration = true;
    extensions = [
      "nix"
      "golangci-lint"
      "catppuccin"
      "html"
    ];
    extraPackages = with pkgs; [
      nil
      nixd
    ];
    userSettings = {
      disable_ai = true;
      vim_mode = true;
      base_keymap = "JetBrains";
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      collaboration_panel = {
        button = false;
      };
      which_key = {
        enabled = true;
        delay_ms = 10;
      };
    };
  };
}
