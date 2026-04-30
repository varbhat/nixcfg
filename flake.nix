{
  description = "vbt's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Nixvim
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    vars = import ./vars.nix;
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      # nh os switch . -H ryze
      # sudo nixos-rebuild switch --flake '.#ryze'
      ryze = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs vars;};
        modules = [
          # Host
          ./host/ryze/default.nix

          # Modules
          ./modules/nixos/android.nix
          ./modules/nixos/avahi.nix
          ./modules/nixos/base.nix
          ./modules/nixos/bluetooth.nix
          ./modules/nixos/boot.nix
          ./modules/nixos/container.nix
          ./modules/nixos/desktop.nix
          ./modules/nixos/dvorak.nix
          ./modules/nixos/flatpak.nix
          ./modules/nixos/i2c.nix
          ./modules/nixos/kernel.nix
          ./modules/nixos/network.nix
          ./modules/nixos/packages.nix
          ./modules/nixos/power.nix
          ./modules/nixos/shell.nix
          ./modules/nixos/ssh.nix
          ./modules/nixos/syncthing.nix
          ./modules/nixos/tailscale.nix
          ./modules/nixos/time.nix
          ./modules/nixos/user.nix
          #./modules/nixos/virtmanager.nix
          #./modules/nixos/waydroid.nix
          ./modules/nixos/wifi.nix
        ];
      };

      # nh os switch . -H frame
      # sudo nixos-rebuild switch --flake '.#frame'
      frame = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs vars;};
        modules = [
          # Host
          ./host/framework13/default.nix
          inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series

          # Modules
          ./modules/nixos/android.nix
          ./modules/nixos/avahi.nix
          ./modules/nixos/base.nix
          ./modules/nixos/bluetooth.nix
          ./modules/nixos/boot.nix
          ./modules/nixos/container.nix
          ./modules/nixos/desktop.nix
          ./modules/nixos/dvorak.nix
          ./modules/nixos/flatpak.nix
          ./modules/nixos/i2c.nix
          ./modules/nixos/kernel.nix
          ./modules/nixos/network.nix
          ./modules/nixos/packages.nix
          ./modules/nixos/power.nix
          ./modules/nixos/shell.nix
          ./modules/nixos/ssh.nix
          ./modules/nixos/syncthing.nix
          ./modules/nixos/tailscale.nix
          ./modules/nixos/time.nix
          ./modules/nixos/user.nix
          #./modules/nixos/virtmanager.nix
          #./modules/nixos/waydroid.nix
          ./modules/nixos/wifi.nix
        ];
      };

      # nixos-rebuild switch --flake '.#abhra' --target-host user@server-ip --sudo --ask-sudo-password
      abhra = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs vars;};
        modules = [
          # Host
          ./host/abhra/default.nix

          # Modules
          ./modules/nixos/base.nix
          ./modules/nixos/packages.nix
          ./modules/nixos/ssh.nix
          ./modules/nixos/tailscale.nix
        ];
      };
    };

    homeConfigurations = {
      # nh home switch . -c 'vbt@ryze'
      # home-manager switch --flake '.#vbt@ryze'
      "vbt@ryze" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs vars;};
        modules = [
          ./modules/home/aibase.nix
          ./modules/home/base.nix
          ./modules/home/codium.nix
          ./modules/home/desktop.nix
          ./modules/home/distrobox.nix
          ./modules/home/firefox.nix
          ./modules/home/git.nix
          ./modules/home/gtk.nix
          ./modules/home/keepassxc.nix
          ./modules/home/mpv.nix
          ./modules/home/neovim.nix
          ./modules/home/packages.nix
          ./modules/home/shell.nix
          ./modules/home/terminal.nix
          ./modules/home/vbthome.nix
          ./modules/home/xdg.nix
          ./modules/home/yazi.nix
          ./modules/home/ytdlp.nix
          ./modules/home/zed.nix
        ];
      };

      # nh home switch . -c 'vbt@frame'
      # home-manager switch --flake '.#vbt@frame'
      "vbt@frame" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs vars;};
        modules = [
          ./modules/home/aibase.nix
          ./modules/home/base.nix
          ./modules/home/codium.nix
          ./modules/home/desktop.nix
          ./modules/home/distrobox.nix
          ./modules/home/firefox.nix
          ./modules/home/git.nix
          ./modules/home/gtk.nix
          ./modules/home/keepassxc.nix
          ./modules/home/mpv.nix
          ./modules/home/neovim.nix
          ./modules/home/packages.nix
          ./modules/home/shell.nix
          ./modules/home/terminal.nix
          ./modules/home/vbthome.nix
          ./modules/home/xdg.nix
          ./modules/home/yazi.nix
          ./modules/home/ytdlp.nix
          ./modules/home/zed.nix
        ];
      };
    };
  };
}
