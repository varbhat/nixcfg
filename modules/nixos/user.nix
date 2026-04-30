{
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
  ];

  users.users.${vars.userName} = {
    isNormalUser = true;
    description = "vbt";
    initialPassword = "password"; # Change it after creation
    shell = pkgs.bash;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "audio"
      "input"
      "video"
      "systemd-journal"
      "network"
      "i2c"
      "kvm"
      "libvirtd"
      "adbusers"
    ];
    packages = with pkgs; [
    ];
  };

  nix.settings.trusted-users = [
    "root"
    vars.userName
  ];

  security.sudo.extraRules = [
    {
      users = [vars.userName];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
