{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
