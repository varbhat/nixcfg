{...}: {
  imports = [
  ];
  networking.hostName = "ryze"; # hostname of ryze
  hardware.amdgpu.initrd.enable = true;
}
