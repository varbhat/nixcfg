{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi

      if command -v starship >/dev/null; then
        eval "$(starship init bash)"
      fi
      if command -v zoxide >/dev/null; then
        eval "$(zoxide init bash)"
      fi
    '';
    profileExtra = ''
      export EDITOR=nvim
      export GOPATH="$HOME/.local/share/gopath";
      export PATH="$PATH:$GOPATH/bin"
      export PATH="$PATH:$HOME/.cargo/bin"
      export PATH="$PATH:$HOME/.local/bin"
      export PATH="$PATH:$HOME/.local/vbin"

      # Wayland
      export QT_QPA_PLATFORM=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -g fish_key_bindings fish_vi_key_bindings
      starship init fish | source
      zoxide init fish | source

      fish_add_path $GOPATH/bin
      fish_add_path $HOME/.cargo/bin
      fish_add_path $HOME/.local/bin
      fish_add_path $HOME/.local/vbin

      if type -q eza
        alias ls='eza --icons=auto --hyperlink'
      end

      if type -q batman
        alias man='batman'
      end

      if type -q flatpak
        abbr --add fin 'flatpak install flathub --user'
        abbr --add flathub 'flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo'
        abbr --add fun 'flatpak uninstall --user'
        abbr --add frun 'flatpak run --user'
        abbr --add fundelete 'flatpak uninstall --user --delete-data'
        abbr --add fclean 'flatpak uninstall --user --unused --delete-data'
        abbr --add fupdate 'flatpak update --user'
      end

      # Creates Required Directories if not present
      mkdir -p ~/.cache \
               ~/.config \
               ~/space \
               ~/.local/sockets \
    '';
    shellAliases = {
      v = "nvim";
      diff = "diff --color=auto";
      grep = "grep --color=auto";
      ip = "ip -color=auto";
      g = "git";
      lg = "lazygit";
      ldo = "lazydocker";
      aget = "aria2c";
    };
    shellAbbrs = {
      chx = "chmod +x";
      lsa = "ls -a";
      lsta = "lst -a";
    };
    functions = {
      pastebin = ''curl -F "file=@-" https://0x0.st'';
      cl = "cd $argv; and ls -a";
      mkcd = "mkdir -p $argv; and cd $argv";
      run = "setsid $argv &>/dev/null &";
      getMime = "file -b --mime-type $argv";
      sshKeyGen = "ssh-keygen -t ed25519 -C \"\" $argv";
      # yazi integration
      n = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          builtin cd -- "$cwd"
        end
          rm -f -- "$tmp"
      '';
      lst = "eza -T --icons=always --hyperlink --color=always $argv | bat --color=always --style=plain";
      zl = "z $argv; and ls -a";
    };
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "fzf.fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
  };

  programs.starship = {
    enable = true;
  };

  # Several Scripts here
  # home.file.".local/vbin" = {
  #   source = ../../assets/vbin;
  #   recursive = true;
  # };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
      prettybat
    ];
  };

  programs.eza = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };
}
