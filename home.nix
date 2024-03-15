{ config, pkgs, ... }:

let
  terraform_cache_dir = ".terraform.d/plugin-cache";

in
{
  home.username = "mheiber";
  home.homeDirectory = "/home/mheiber";
  home.stateVersion = "23.11";
  news.display = "silent";

  home.packages = with pkgs; [
    httpie
    jq
    urlscan
    mutt
    transmission_4-gtk
    unzip
    whois
    htop
    unrar
    w3m
    pinentry-curses
    gimp
    nettools
    silver-searcher
    amazon-ecr-credential-helper
    vscodium
    jotta-cli
    gh
    vlc
    mpv
    mpvScripts.inhibit-gnome
    bmon
    ripgrep
    google-chrome
    go
    streamlink
    tzupdate
    gopass
    goss
    dgoss
    awscli2
    libheif
    libva-utils
    xdg-desktop-portal-gnome
    shellcheck

    nixpkgs-fmt
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  home.file = {
    ".terraformrc".text = ''
      plugin_cache_dir = "''${HOME}/${terraform_cache_dir}"
      disable_checkpoint = true
    '';
    "${terraform_cache_dir}/.keep".text = "";
  };

  home.sessionVariables = {
    DOCKER_BUILDKIT = 1;
    GTK_IM_MODULE = "xim";
    BROWSER = "firefox";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    bash = {
      enable = true;
      historyIgnore = [
        "ls"
        "cd"
        "exit"
      ];
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    mcfly = {
      enable = true;
      enableBashIntegration = true;
      fzf.enable = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    eza = {
      enable = true;
      enableBashIntegration = true;
      icons = true;
      git = true;
    };
    git = {
      enable = true;
      userName = "Moritz Heiber";
      userEmail = "hello@heiber.im";
      delta.enable = true;
      extraConfig = {
        pull.rebase = true;
        push.default = "simple";
        push.followTags = true;
        init.defaultBranch = "main";
        delta.navigate = true;
        delta.side-by-side = true;
        branch.sort = "committerdate";
        log.showSignature = true;
        diff.colorMoved = "default";
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraPython3Packages = pyPkgs: with pyPkgs; [
        python-lsp-server
      ];

      withRuby = true;

      extraPackages = with pkgs; [
        gopls
        wl-clipboard
        rubyPackages_3_3.solargraph
        hadolint
        terraform-ls
        ruff
      ];

      plugins = with pkgs.vimPlugins; [
        neo-tree-nvim
        nvim-web-devicons
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        telescope-nvim
        telescope-fzf-native-nvim
        vim-gitgutter
        autoclose-nvim
        nvim-surround
        (nvim-treesitter.withPlugins
          (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-json
            p.tree-sitter-go
            p.tree-sitter-rust
            p.tree-sitter-dockerfile
          ])
        )

        indent-blankline-nvim
        vim-nix
        {
          plugin = vim-airline;
          config = ''
            let g:airline_powerline_fonts = 1
            let g:airline#extensions#tabline#enabled = 2
            let g:airline_detect_spell=1
            let g:airline_detect_paste=1
            let g:airline_detect_crypt=1
            let g:airline_detect_modified=1
            let g:airline_theme= 'luna'
            let g:airline#extensions#ale#enabled = 1

          '';
        }
        vim-airline-themes
        vim-ruby
        typescript-vim
        vim-go

        {
          plugin = gruvbox-community;
          config = ''
            let g:gruvbox_italic=1
            set background=dark
            let g:gruvbox_contrast_dark = "hard"
          '';
        }
        {
          plugin = rust-vim;
          config = "let g:rustfmt_autosave = 1";
        }
        {
          plugin = vim-terraform;
          config = "let g:terraform_fmt_on_save = 1";
        }
        vim-terraform-completion
      ];

      extraConfig = ''
        set fileencodings=utf-8
        set encoding=utf-8
        scriptencoding utf-8
        filetype plugin on
        set omnifunc=syntaxcomplete#Complete
        set completeopt-=preview
        colorscheme gruvbox

        let mapleader = ","

        syntax on
        set termguicolors
        set showcmd
        set showmatch
        set noshowmode
        set ruler
        set cursorline
        set number
        set formatoptions+=o
        set expandtab
        set shiftwidth=2
        set tabstop=2
        set laststatus=2
        set wildmode=longest,list,full
        set wildmenu
        set lazyredraw
        set clipboard+=unnamedplus

        set noerrorbells
        set modeline
        set linespace=0
        set nojoinspaces
        set nostartofline
        set foldenable
        set foldlevelstart=10
        set foldnestmax=10
        set foldmethod=indent
        nnoremap <space> za

        set hlsearch
        set incsearch
        set ignorecase
        set smartcase
        set gdefault
        set magic
        nnoremap <leader><space> :nohlsearch<CR>

        vmap v <Plug>(expand_region_expand)
        vmap <C-v> <Plug>(expand_region_shrink)

        if &listchars ==# 'eol:$'
          set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
        endif
        set list

        highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
        match ExtraWhitespace /\s\+$\|\t/
      '';
    };
  };
}

