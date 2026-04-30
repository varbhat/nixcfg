{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    font = {
      name = "monospace";
      size = 13;
    };
    # settings = {
    #   shell = "${pkgs.fish}/bin/fish --interactive";
    # };
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = ["kitty.desktop"];
  };
}
