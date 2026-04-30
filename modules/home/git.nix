{
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
  ];

  programs.git = {
    enable = true;
    settings = {
      init = {
        defaultBranch = "main";
      };

      core = {
        pager = "delta";
      };

      help = {
        autoCorrect = "prompt";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };

      delta = {
        navigate = "true"; # use n and N to move between diff sections
        side-by-side = "true";
        line-numbers = "true";
        features = "decorations";
      };

      merge = {
        conflictstyle = "diff3";
      };

      diff = {
        colorMoved = "default";
      };

      push = {
        autoSetupRemote = "true";
      };

      # Aliases
      alias = {
        br = "branch";
        ci = "commit";
        cia = "commit --amend";
        cl = "clone";
        co = "checkout";
        committers = "shortlog --summary --numbered";
        cp = "cherry-pick";
        di = "diff";
        ft = "fetch";
        yolo = ''!git commit -m "$(curl -s https://whatthecommit.com/index.txt)"'';
        h = "help";
        l = "log";
        log1 = "log --pretty=oneline";
        logs = "log --stat";
        logself = "!sh -c 'git log --author=$(git config user.email)'";
        logself1 = "!sh -c 'git log --author=$(git config user.email) --pretty=oneline'";
        logr = "log --graph --decorate --pretty=oneline --abbrev-commit";
        logra = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        ls = "ls-files";
        mb = "merge-base";
        originurl = "config --get remote.origin.url";
        pu = "push";
        pushall = "!git remote | xargs -L1 git push --all"; # Ref: https://stackoverflow.com/a/18674313
        pa = "pushall";
        pushfwl = "push --force-with-lease"; # Ref: https://stackoverflow.com/a/43726130/265508
        rb = "rebase";
        re = "restore";
        sha1head = ''!"git rev-parse HEAD | tee /dev/tty | tr -d '\n' | wl-copy"''; # sha1head = rev-parse HEAD
        st = "status";
        stashshow0 = "stash show -p stash@{0}";
        stat = "status";
        sub = "submodule";
        sw = "switch";
        # Show recent branches. Ref: https://news.ycombinator.com/item?id=32467957
        recent = "for-each-ref \
            --sort=-committerdate refs/heads/ \
            --format='%(HEAD) %(color:red)%(objectname:short)%(color:reset) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
      };

      # User Settings Below
      user = {
        email = vars.git.email;
        name = vars.git.name;
        signingkey = vars.git.signingKey; # "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };

      # core = {
      #   sshCommand = "ssh -i ${config.home.homeDirectory}/.ssh/id_ed25519";
      # };

      gpg = {
        format = "ssh";
      };

      commit = {
        gpgSign = "true";
      };

      tag = {
        gpgSign = "true";
      };
    };
    includes = [
      {
        path = "~/space/work/.gitconfig";
        condition = "gitdir:~/space/work/";
      }
    ];
  };

  programs.lazygit = {
    enable = true;
  };

  home.packages = with pkgs; [
    delta
    gh
  ];
}
