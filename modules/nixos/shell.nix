{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };
}
