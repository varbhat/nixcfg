{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    lazydocker
    distrobox
  ];
}
