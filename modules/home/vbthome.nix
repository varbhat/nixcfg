{vars, ...}: {
  imports = [
  ];

  home = {
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
  };
}
