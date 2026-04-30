{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  services.mpris-proxy.enable = true;

  home.packages = with pkgs; [
    #waypipe
    wl-clipboard
    pwvucontrol
  ];
}
