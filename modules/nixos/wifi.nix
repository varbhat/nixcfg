{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  # Enable wireless networking using iwd
  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };
}
