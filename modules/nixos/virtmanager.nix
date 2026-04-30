{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
  };

  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  # Support UEFI Firmware
  systemd.tmpfiles.rules = ["L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    #"riscv64-linux"
  ];

  environment.systemPackages = with pkgs; [
    dnsmasq
  ];
}
