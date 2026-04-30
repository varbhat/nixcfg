{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk2.enable = false;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    };
  };
}
