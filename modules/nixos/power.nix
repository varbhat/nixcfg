{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  #services.tlp.enable = true;
  services.power-profiles-daemon.enable = true;
}
