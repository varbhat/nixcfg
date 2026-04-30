{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.mpris
      mpvScripts.thumbfast
      mpvScripts.mpv-playlistmanager
      # mpvScripts.simple-mpv-ui
      mpvScripts.uosc
    ];
    config = {
      osc = "no"; # uosc
      hwdec = "vaapi";
      gpu-context = "wayland";
      keep-open = "yes";
      force-window = "immediate";
      ao = "pipewire";
      alang = "eng";
      slang = "eng";
      sub-auto = "fuzzy";
      save-position-on-quit = "yes";
      screenshot-template = "%F - [%P]v%#01n";
      screenshot-format = "png";
      ytdl-raw-options = "sub-lang=en,write-auto-sub=";
      ytdl-format = "bestvideo[height<=720]+bestaudio";
      cache = "yes";
      demuxer-max-bytes = "1GiB";
      prefetch-playlist = "yes";
    };
    bindings = {
      "ctrl+r" = ''cycle_values video-rotate "90" "180" "270" "0"'';
      "k" = ''script-message playlistmanager playlist-next'';
      "shift+k" = ''script-message playlistmanager playlist-prev'';
      ";" = ''script-message playlistmanager shuffle'';
    };
  };

  home.packages = with pkgs; [
    open-in-mpv
  ];

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mpv" = ["open-in-mpv.desktop"];
  };
}
