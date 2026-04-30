{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  hardware.steam-hardware.enable = true;
}
