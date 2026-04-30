{...}: {
  imports = [
  ];
  networking.hostName = "frame"; # hostname of framework13
  hardware.amdgpu.initrd.enable = true;
}
