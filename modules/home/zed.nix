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
      vim_mode = true;
      base_keymap = "JetBrains";
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      which_key = {
        enabled = true;
      };
    };
  };
}
