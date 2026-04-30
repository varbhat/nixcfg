{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    aria2
    file
    btop
    killall
    fastfetch
    jq
    fzf
    acpi
    lm_sensors
    nh
    systemctl-tui
  ];

  programs.nano.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
