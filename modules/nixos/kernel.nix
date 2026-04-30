{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  # Use latest Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
