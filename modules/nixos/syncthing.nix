{
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
    user = vars.userName;
    group = "users";
    configDir = "/home/${vars.userName}/.config/syncthing";
  };
}
