{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  environment.systemPackages = with pkgs; [
    waydroid-helper
  ];
}
