{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  home.packages = with pkgs; [
    pi-coding-agent
    claude-code
    nodejs_latest
    #agent-browser
    #chromium
  ];

  programs.mcp = {
    #enable = true;
  };
}
