{
  userName = "vbt";

  ssh.authorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrH4zBTUfxvvTUtNS/Umf2G57h/TTH07bGlvLtrjEym"
  ];

  git = {
    name = "varbhat";
    email = "mailvarbhat@gmail.com";
    signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrH4zBTUfxvvTUtNS/Umf2G57h/TTH07bGlvLtrjEym vbt";
  };
}
