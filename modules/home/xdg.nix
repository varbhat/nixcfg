{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  xdg = {
    portal.xdgOpenUsePortal = true;
    localBinInPath = true;
    autostart.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
