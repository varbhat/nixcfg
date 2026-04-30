{
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = [
  ];
  networking.hostName = "nabha"; # hostname of nabha

  networking.wireless.iwd = {
    enable = true;
    settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };

  networking.dhcpcd.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
      80
      443
      8123 # Home-assistant
      8095 # Music-assistant
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
      {
        from = 32768;
        to = 60999;
      } # SSDP replies (Linux ephemeral range)
    ];
    allowedUDPPorts = [
      5353 # mDNS/zeroconf: Cast, HomeKit, ESPHome, Matter
      1900 # SSDP announcements: Sonos, Hue, TVs
      5540 # Matter, only if you use it
    ];
  };

  users = {
    users = {
      admin = {
        isNormalUser = true;
        extraGroups = ["wheel" "docker"];
        initialHashedPassword = "!";
        openssh.authorizedKeys.keys = vars.ssh.authorizedKeys;
      };
    };
  };
  nix.settings.trusted-users = ["admin"];

  # Docker User
  users = {
    groups.dockersvc = {
      gid = 2000; # group for docker service containers
    };

    users.dockersvc = {
      isSystemUser = true;
      uid = 2000;
      group = "dockersvc";
      home = "/srv/docker";
      createHome = true;
      description = "Runs docker services";
    };
  };

  environment.systemPackages = with pkgs; [
    zellij
  ];
  environment.enableAllTerminfo = true;
}
