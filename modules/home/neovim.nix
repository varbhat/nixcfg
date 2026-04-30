{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nixvim.homeModules.nixvim];

  programs.nixvim = let
    inherit (config.lib.nixvim) mkRaw;
  in {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };

    opts = {
      number = true;
      mouse = "a";
      showmode = false;
      clipboard = "unnamedplus";
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      inccommand = "split";
      cursorline = true;
      scrolloff = 10;
      title = true;
      # Treesitter-based folding
      foldenable = true;
      foldmethod = "expr";
      foldlevelstart = 999;
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldtext = "v:lua.vim.treesitter.foldtext()";
      winborder = "rounded";
    };

    diagnostic.settings = {
      severity_sort = true;
      virtual_text.current_line = true;
      float.border = "rounded";
    };

    userCommands = {
      FormatGlobalToggle = {
        desc = "Toggle Global autoformat-on-save";
        command = mkRaw "function() vim.g.disable_autoformat = not vim.g.disable_autoformat end";
      };
      FormatBufferToggle = {
        desc = "Toggle Buffer autoformat-on-save";
        command = mkRaw "function() vim.b.disable_autoformat = not vim.b.disable_autoformat end";
      };
    };

    autoGroups = {
      text-highlight-yank.clear = true;
      text-lsp-highlight.clear = false;
    };

    autoCmd = [
      {
        event = "TextYankPost";
        group = "text-highlight-yank";
        desc = "Highlight when yanking text";
        callback = mkRaw "function() vim.highlight.on_yank() end";
      }
      {
        event = ["CursorHold" "CursorHoldI"];
        group = "text-lsp-highlight";
        desc = "Highlight LSP references";
        callback = mkRaw "function() vim.lsp.buf.document_highlight() end";
      }
      {
        event = ["CursorMoved" "CursorMovedI"];
        group = "text-lsp-highlight";
        desc = "Clear LSP references";
        callback = mkRaw "function() vim.lsp.buf.clear_references() end";
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlights";
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = "n";
        key = "<leader>dd";
        action = mkRaw "vim.diagnostic.open_float";
        options.desc = "Line Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>Q";
        action = mkRaw "vim.diagnostic.setloclist";
        options.desc = "Open diagnostic [Q]uickfix list";
      }

      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options.desc = "Move focus to the left window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options.desc = "Move focus to the right window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options.desc = "Move focus to the lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options.desc = "Move focus to the upper window";
      }

      {
        mode = "n";
        key = "<leader>th";
        action = mkRaw "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end";
        options.desc = "[T]oggle Inlay [H]ints";
      }

      # Quit
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>q<cr>";
        options.desc = "Quit";
      }
      {
        mode = "n";
        key = "<leader>qa";
        action = "<cmd>qa<cr>";
        options.desc = "Quit All";
      }
      {
        mode = "n";
        key = "<leader>qf";
        action = "<cmd>q!<cr>";
        options.desc = "Force Quit";
      }
      {
        mode = "n";
        key = "<leader>qF";
        action = "<cmd>qa!<cr>";
        options.desc = "Force Quit All";
      }
      {
        mode = "n";
        key = "<leader>qw";
        action = "<cmd>wq<cr>";
        options.desc = "Write and Quit";
      }
      {
        mode = "n";
        key = "<leader>qW";
        action = "<cmd>wqa<cr>";
        options.desc = "Write and Quit All";
      }

      # Save
      {
        mode = ["i" "x" "n" "s"];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options.desc = "Save File";
      }

      # Resize
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase Window Height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease Window Height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease Window Width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase Window Width";
      }

      # Buffers
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "<leader>ed";
        action = "<cmd>bd<cr>";
        options.desc = "[d]elete Buffer";
      }

      # Format toggles
      {
        mode = "n";
        key = "<leader>tF";
        action = "<cmd>FormatGlobalToggle<cr>";
        options.desc = "Toggle Global autoformat-on-save";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>FormatBufferToggle<cr>";
        options.desc = "Toggle Buffer autoformat-on-save";
      }

      # Bufferline
      {
        mode = "n";
        key = "<leader>ep";
        action = "<cmd>BufferLineTogglePin<cr>";
        options.desc = "[p]in the Buffer";
      }

      # Mini.files
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>lua MiniFiles.open()<CR>";
        options.desc = "[O]pen";
      }

      # Flash
      {
        mode = "n";
        key = "s";
        action = mkRaw "function() require('flash').jump() end";
        options.desc = "Flash";
      }
      {
        mode = "n";
        key = "S";
        action = mkRaw "function() require('flash').treesitter() end";
        options.desc = "Flash Treesitter";
      }
      {
        mode = "o";
        key = "r";
        action = mkRaw "function() require('flash').remote() end";
        options.desc = "Remote Flash";
      }
      {
        mode = ["o" "x"];
        key = "R";
        action = mkRaw "function() require('flash').treesitter_search() end";
        options.desc = "Treesitter Search";
      }
      {
        mode = "c";
        key = "<c-s>";
        action = mkRaw "function() require('flash').toggle() end";
        options.desc = "Toggle Flash Search";
      }

      # Grapple
      {
        mode = "n";
        key = "<leader>m";
        action = "<cmd>Grapple toggle<cr>";
        options.desc = "[m]Grapple toggle tag";
      }
      {
        mode = "n";
        key = "<leader>M";
        action = "<cmd>Grapple toggle_tags<cr>";
        options.desc = "[M]Grapple open tags window";
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>Grapple cycle_tags next<cr>";
        options.desc = "Grapple cycle [n]ext tag";
      }
      {
        mode = "n";
        key = "<leader>p";
        action = "<cmd>Grapple cycle_tags prev<cr>";
        options.desc = "Grapple cycle [p]revious tag";
      }

      # Conform format
      {
        mode = "";
        key = "<leader>f";
        action = mkRaw "function() require('conform').format { async = true, lsp_format = 'fallback' } end";
        options.desc = "[F]ormat buffer";
      }

      # FzfLua
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>FzfLua<cr>";
        options.desc = "[S]earch [S]elect FzfLua";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sh";
        action = mkRaw "require('fzf-lua').helptags";
        options.desc = "[S]earch [H]elp";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sk";
        action = mkRaw "require('fzf-lua').keymaps";
        options.desc = "[S]earch [K]eymaps";
      }
      {
        mode = ["n" "v"];
        key = "<leader>s<leader>";
        action = mkRaw "require('fzf-lua').files";
        options.desc = "[S]earch [F]iles";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sw";
        action = mkRaw "require('fzf-lua').grep_cword";
        options.desc = "[S]earch [w]ord";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sW";
        action = mkRaw "require('fzf-lua').grep_cWORD";
        options.desc = "[S]earch [W]ORD";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sg";
        action = mkRaw "require('fzf-lua').live_grep";
        options.desc = "[S]earch live [g]rep";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sc";
        action = mkRaw "function() require('fzf-lua').grep { raw_cmd = [[git status -su | rg \"^\\s*M\" | cut -d ' ' -f3]] } end";
        options.desc = "[S]earch [c]hanged git files";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sC";
        action = mkRaw "function() require('fzf-lua').grep { raw_cmd = [[git status -su | rg \"^\\s*M\" | cut -d ' ' -f3 | xargs rg --hidden --column --line-number --no-heading --color=always --with-filename -e '']] } end";
        options.desc = "[S]earch in [C]hanged git files";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sd";
        action = mkRaw "require('fzf-lua').diagnostics_document";
        options.desc = "[S]earch Document [d]iagnostics";
      }
      {
        mode = ["n" "v"];
        key = "<leader>s=";
        action = mkRaw "require('fzf-lua').resume";
        options.desc = "[S]earch Resume";
      }
      {
        mode = ["n" "v"];
        key = "<leader>s.";
        action = mkRaw "require('fzf-lua').oldfiles";
        options.desc = "[S]earch Recent Files";
      }
      {
        mode = ["n" "v"];
        key = "<leader>st";
        action = mkRaw "require('fzf-lua').tabs";
        options.desc = "[S]earch [t]abs";
      }
      {
        mode = ["n" "v"];
        key = "<leader><leader>";
        action = mkRaw "require('fzf-lua').buffers";
        options.desc = "[ ] Find existing buffers";
      }
      {
        mode = ["n" "v"];
        key = "<leader>/";
        action = mkRaw "require('fzf-lua').lgrep_curbuf";
        options.desc = "[/] Fuzzily search in current buffer";
      }
      {
        mode = ["n" "v"];
        key = "<leader>s/";
        action = mkRaw "require('fzf-lua').lines";
        options.desc = "[S]earch [/] in Open Files";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sR";
        action = mkRaw "require('fzf-lua').registers";
        options.desc = "[S]earch [R]egisters";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sy";
        action = mkRaw "require('fzf-lua').grep_visual";
        options.desc = "[S]earch Visual";
      }
      {
        mode = ["n" "v"];
        key = "<leader>sp";
        action = mkRaw "require('fzf-lua').grep_project";
        options.desc = "[S]earch [p]roject";
      }

      # Trouble
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options.desc = "LSP Definitions / references (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List (Trouble)";
      }

      # LSP window commands
      {
        mode = "n";
        key = "<leader>li";
        action = "<cmd>LspInfo<cr>";
        options.desc = "LSP [i]nfo";
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>LspRestart<cr>";
        options.desc = "LSP [R]estart";
      }

      # Grug-far
      {
        mode = ["n" "v"];
        key = "<leader>sr";
        action = mkRaw ''
          function()
            local grug = require('grug-far')
            local ext = vim.bo.buftype == "" and vim.fn.expand '%:e'
            grug.open {
              transient = true,
              prefills = {
                filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              },
            }
          end
        '';
        options.desc = "[S]earch and [r]eplace";
      }
    ];

    colorscheme = "catppuccin-macchiato";
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        color_overrides.macchiato = {
          rosewater = "#c4b28a";
          flamingo = "#d9a594";
          pink = "#D27E99";
          mauve = "#c6b6ee";
          red = "#E46876";
          maroon = "#c4746e";
          peach = "#FFA066";
          yellow = "#E6C384";
          green = "#a6e3a1";
          teal = "#5a7785";
          sky = "#9fb5c9";
          sapphire = "#b8b4d0";
          blue = "#7FB4CA";
          lavender = "#8197bf";
          text = "#c5c9c5";
          subtext1 = "#a6a69c";
          subtext0 = "#9e9b93";
          overlay2 = "#8a8980";
          overlay1 = "#8f8b8b";
          overlay0 = "#726e6e";
          surface2 = "#625e5a";
          surface1 = "#393836";
          surface0 = "#282727";
          base = "#0d0c0c";
          mantle = "#1D1C19";
          crust = "#1F1F28";
        };
        integrations = {
          blink_cmp = true;
          flash = true;
          fzf = true;
          gitsigns = true;
          indent_blankline.enabled = true;
          lsp_trouble = true;
          markdown = true;
          mini = true;
          native_lsp = {
            enabled = true;
            underlines = {
              errors = ["undercurl"];
              hints = ["undercurl"];
              warnings = ["undercurl"];
              information = ["undercurl"];
            };
          };
          semantic_tokens = true;
          which_key = true;
        };
      };
    };

    plugins = {
      web-devicons.enable = true;
      gitsigns.enable = true;
      treesitter.enable = true;

      lualine = {
        enable = true;
        settings = {
          options = {
            icons_enabled = true;
            theme = "auto";
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
            always_divide_middle = true;
            globalstatus = false;
          };
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff" "diagnostics"];
            lualine_c = ["filename"];
            lualine_x = ["encoding" "fileformat" "filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
          inactive_sections = {
            lualine_a = [];
            lualine_b = [];
            lualine_c = ["filename"];
            lualine_x = ["location"];
            lualine_y = [];
            lualine_z = [];
          };
        };
      };

      bufferline = {
        enable = true;
        settings.options.diagnostics = "nvim_lsp";
      };

      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
          };
          scope = {
            show_start = false;
            show_end = false;
          };
          exclude.filetypes = [
            "help"
            "alpha"
            "dashboard"
            "neo-tree"
            "Trouble"
            "trouble"
            "lazy"
            "mason"
            "notify"
            "toggleterm"
            "lazyterm"
          ];
        };
      };

      which-key = {
        enable = true;
        settings.spec = [
          {
            __unkeyed-1 = "<leader>c";
            group = "[C]ode";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "[D]ocument";
          }
          {
            __unkeyed-1 = "<leader>e";
            group = "[E]ditor";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "[L]sp";
          }
          {
            __unkeyed-1 = "<leader>r";
            group = "[R]ename";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "[W]orkspace";
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "[Q]uit/Sessions";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle/est";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "[x]Trouble";
          }
        ];
      };

      mini = {
        enable = true;
        modules = {
          ai.n_lines = 500;
          surround = {};
          files = {};
          diff = {};
          move = {};
          pairs = {};
          splitjoin = {};
          comment = {};
          hipatterns = {
            highlighters = {
              fixme = {
                pattern = "%f[%w]()FIXME()%f[%W]";
                group = "MiniHipatternsFixme";
              };
              hack = {
                pattern = "%f[%w]()HACK()%f[%W]";
                group = "MiniHipatternsHack";
              };
              todo = {
                pattern = "%f[%w]()TODO()%f[%W]";
                group = "MiniHipatternsTodo";
              };
              note = {
                pattern = "%f[%w]()NOTE()%f[%W]";
                group = "MiniHipatternsNote";
              };
              hex_color.__raw = "require('mini.hipatterns').gen_highlighter.hex_color()";
            };
          };
        };
      };

      flash = {
        enable = true;
        settings.modes.search.enabled = false;
      };

      guess-indent.enable = true;

      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "\"<c-/>\"";
          hide_number = true;
          start_in_insert = true;
          direction = "float";
        };
      };

      fidget.enable = true;

      blink-cmp = {
        enable = true;
        settings = {
          fuzzy = {
            sorts = ["exact" "score" "sort_text"];
            implementation = "prefer_rust_with_warning";
          };
          completion = {
            list.selection.preselect = false;
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 500;
            };
          };
          keymap.preset = "enter";
          cmdline = {
            keymap.preset = "enter";
            completion = {
              menu.auto_show = mkRaw "function() return vim.fn.getcmdtype() == ':' end";
              list.selection.preselect = false;
            };
          };
          term.keymap.preset = "super-tab";
          signature.enabled = true;
          appearance.nerd_font_variant = "mono";
          sources.default = ["lsp" "path" "snippets" "buffer"];
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          notify_on_error = false;
          formatters_by_ft = {
            lua = ["stylua"];
            go = ["gofmt"];
          };
          format_on_save = mkRaw ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              local disable_filetypes = { c = true, cpp = true }
              local lsp_format_opt = "fallback"
              if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = "never"
              end
              return { timeout_ms = 500, lsp_format = lsp_format_opt }
            end
          '';
        };
      };

      fzf-lua = {
        enable = true;
        settings = {
          lsp.jump1 = true;
          fzf_colors = true;
          grep.rg_glob = true;
          keymap.builtin."<C-/>" = "toggle-help";
        };
      };

      trouble.enable = true;

      grug-far = {
        enable = true;
        settings.headerMaxWidth = 80;
      };

      lspconfig.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
      grapple-nvim
    ];

    extraPackages = with pkgs; [
      stylua
      go
      fzf
    ];

    # Small lua escape-hatches that have no nix option equivalent
    extraConfigLuaPost = ''
      require('fzf-lua').register_ui_select()
      require('grapple').setup({ scope = 'git' })
      pcall(function() require('vim._core.ui2').enable({}) end)
      vim.cmd.hi 'Comment gui=none'
    '';

    lsp = {
      servers = {
        gopls.enable = true;
        templ.enable = true;
        vtsls.enable = true;
        tailwindcss.enable = true;
        html.enable = true;
        cssls.enable = true;
        basedpyright.enable = true;
        clangd.enable = true;
        stylua.enable = true;
        bashls.enable = true;
        jqls.enable = true;
        jsonls.enable = true;
        sqls.enable = true;
        taplo.enable = true;
        yamlls.enable = true;
        rust_analyzer.enable = true;
        svelte.enable = true;
        docker_compose_language_service.enable = true;
        nixd.enable = true;
        jdtls.enable = true;
        docker_language_server.enable = true;
        lua_ls.enable = true;
      };

      keymaps = [
        {
          key = "gd";
          action = mkRaw "require('fzf-lua').lsp_definitions";
          options.desc = "LSP: [G]oto [D]efinition";
        }
        {
          key = "gR";
          action = mkRaw "require('fzf-lua').lsp_references";
          options.desc = "LSP: [G]oto [R]eferences";
        }
        {
          key = "gI";
          action = mkRaw "require('fzf-lua').lsp_implementations";
          options.desc = "LSP: [G]oto [I]mplementation";
        }
        {
          key = "<leader>D";
          action = mkRaw "require('fzf-lua').lsp_typedefs";
          options.desc = "LSP: Type [D]efinition";
        }
        {
          key = "<leader>ds";
          action = mkRaw "require('fzf-lua').lsp_document_symbols";
          options.desc = "LSP: [D]ocument [S]ymbols";
        }
        {
          key = "<leader>ws";
          action = mkRaw "require('fzf-lua').lsp_workspace_symbols";
          options.desc = "LSP: [W]orkspace [S]ymbols";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
          options.desc = "LSP: [R]e[n]ame";
        }
        {
          key = "<leader>ca";
          action = mkRaw "require('fzf-lua').lsp_code_actions";
          options.desc = "LSP: [C]ode [A]ction";
        }
        {
          key = "gD";
          action = mkRaw "require('fzf-lua').lsp_declarations";
          options.desc = "LSP: [G]oto [D]eclaration";
        }
      ];
    };
  };
}
