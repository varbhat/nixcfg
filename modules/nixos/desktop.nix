{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  hardware.graphics.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-player
    cosmic-edit
    cosmic-term
    cosmic-reader
  ];

  environment.systemPackages = with pkgs; [
    cosmic-ext-tweaks
  ];

  fonts = {
    packages = with pkgs; [
      inter
      ioskeley-mono.normal
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.symbols-only
    ];
    fontconfig.defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Inter"];
      monospace = ["Ioskeley Mono"];
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
