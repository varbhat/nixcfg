{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  home.packages = with pkgs; [
    zellij
    obs-studio
    libnotify # notify-send
    rsync
    rclone
    lazygit
    lazyjournal
    comma
    nix-index
    unzip
    p7zip
    unrar-free
    zstd
    xz
    bzip2
    chafa
  ];

  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
    };
  };
}
