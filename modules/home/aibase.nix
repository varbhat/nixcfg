{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  home.packages = with pkgs; [
    # https://discourse.nixos.org/t/pi-coding-agent-how-to-install-npm-extensions/77030/2
    (pkgs.symlinkJoin {
      name = "pi-coding-agent";
      buildInputs = [pkgs.makeWrapper];
      paths = [pkgs.pi-coding-agent];
      postBuild = ''
        wrapProgram $out/bin/pi \
          --set NPM_CONFIG_PREFIX ${config.home.homeDirectory}/.pi/npm/ \
          --prefix PATH : ${
          pkgs.lib.makeBinPath [
            pkgs.nodejs_latest
          ]
        }
      '';
    })
    agent-browser
    chromium
  ];

  programs.mcp = {
    #enable = true;
  };
}
