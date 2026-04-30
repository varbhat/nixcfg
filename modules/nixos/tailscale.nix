{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  services.tailscale = {
    enable = true;
    extraSetFlags = ["--netfilter-mode=nodivert"];
  };

  networking.nftables.enable = true;
  networking.firewall = {
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [config.services.tailscale.port];
  };
}
