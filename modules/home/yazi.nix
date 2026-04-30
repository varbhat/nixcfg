{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    initLua = ''
      require("starship"):setup()
      require("full-border"):setup()
      require("cursor-mime"):setup()
    '';
    settings = {
      plugin = {
        prepend_fetchers = [
          # {
          #   url = "local://*";
          #   run = "mime-ext.local";
          #   prio = "high";
          #   group = "mime";
          # }
          #https://github.com/sxyazi/yazi/issues/3596#issuecomment-3780121200
          {
            url = "local://*";
            run = "noop";
            group = "mime";
          }
        ];
      };

      mgr = {
        ratio = [
          0
          2
          6
        ];
      };

      preview = {
        image_delay = 0;
        max_width = 10000;
        max_height = 10000;
      };

      opener = {
        play = [
          {
            #run = ''umpv %s'';
            run = ''mpv %s'';
            orphan = true;
            for = "unix";
          }
        ];
      };

      # tasks = {
      #   # Increase bound limits for Image Preview
      #   image_bound = [
      #     50000
      #     50000
      #   ];
      # };
    };
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      mime-ext = pkgs.yaziPlugins.mime-ext;
      starship = pkgs.yaziPlugins.starship;
    };
  };

  # https://github.com/sxyazi/yazi/issues/3596#issuecomment-3780121200
  xdg.configFile."yazi/plugins/cursor-mime.yazi/main.lua".text = ''
    local function setup()
      local handle
      ps.sub("hover", function()
        if handle then handle:abort() end
        local hovered = cx.active.current.hovered
        if hovered and not hovered:mime() then
          local file = File { url = hovered.url, cha = hovered.cha }
          handle = ya.async(function()
            require("mime-ext.local"):fetch { args = {}, files = { file } }
            -- require("mime.local"):fetch { args = {}, files = { file } }
          end)
        end
      end)
    end

    return { setup = setup }
  '';

  home.packages = with pkgs; [
    poppler # PDF preview
  ];
}
