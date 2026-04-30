{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.yt-dlp = {
    enable = false;
    settings = {
      embed-thumbnail = true;
      embed-subs = true;
      downloader = "aria2c";
    };
  };
}
