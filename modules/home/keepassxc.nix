{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      Browser.Enabled = true;
      GUI = {
        AdvancedSettings = true;
        ApplicationTheme = "dark";
        MinimizeOnClose = true;
        MinimizeToTray = true;
        ShowTrayIcon = true;
      };
      SSHAgent = {
        Enabled = true;
      };
    };
  };
}
