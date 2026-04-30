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
        extraGroups = ["wheel" "docker"];
        initialHashedPassword = "!";
        openssh.authorizedKeys.keys = vars.ssh.authorizedKeys;
      };
    };
  };
  nix.settings.trusted-users = ["admin"];

  environment.systemPackages = with pkgs; [
    zellij
  ];
  environment.enableAllTerminfo = true;

  # services.caddy = {
  #   enable = true;
  #   virtualHosts.":80".extraConfig = ''
  #     respond "Hello, world!"
  #   '';
  # };
}
