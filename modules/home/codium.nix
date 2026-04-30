{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.vscodium = {
    enable = false;
    package = pkgs.vscodium.fhs;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jgclark.vscode-todo-highlight
      ms-python.vscode-pylance
      rust-lang.rust-analyzer
      golang.go
      humao.rest-client
      usernamehw.errorlens
    ];
  };
}
