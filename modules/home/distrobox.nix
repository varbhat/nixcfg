{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.distrobox = {
    enable = true;
    settings = {
      container_always_pull = "1";
      container_manager = "docker";
      container_image_default = "ghcr.io/ublue-os/arch-toolbox";
    };
  };
}
