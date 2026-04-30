{
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = [
  ];
  networking.hostName = "abhra"; # hostname of abhra
  networking.networkmanager.enable = true;

  # Needed by the Hetzner Cloud password reset feature.
  services.qemuGuest.enable = lib.mkDefault true;
  # https://discourse.nixos.org/t/qemu-guest-agent-on-hetzner-cloud-doesnt-work/8864/2
  systemd.services.qemu-guest-agent.path = [pkgs.shadow];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
      80
      443
    ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  users = {
    users = {
      admin = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        initialHashedPassword = "!";
        openssh.authorizedKeys.keys = vars.ssh.authorizedKeys;
      };
    };
  };
  nix.settings.trusted-users = ["admin"];

  environment.systemPackages = with pkgs; [
    ghostty.terminfo
    uv
    zellij
  ];

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = ''
      respond "Hello, world!"
    '';
  };
}
