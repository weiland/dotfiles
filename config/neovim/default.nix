{ config
, pkgs
, lib
, ...
}: let
headlines-nvim = pkgs.vimUtils.buildVimPlugin {
  # name = "headlines-nvim";
  pname = "headlines-nvim";
  version = "2023-03-29";
  src = pkgs.fetchFromGitHub {
    owner = "lukas-reineke";
    repo = "headlines.nvim";
    rev = "ddef41b2664f0ce25fe76520d708e2dc9dfebd70";
    sha256 = "02zri3vmzjxv47qnlll3nf71i9ji8nhdabpvf4566i7iwwagqpym";
  };
};
in {
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  home.packages = with pkgs; [
    # neovim-nightly
    neovim
    lua51Packages.mpack

    # cargo # required for https://github.com/jeertmans/languagetool-rust
    gitlint
    #hadolint # docker linting (failes atm due to ilist-0.4.0.1.drv)
    nil # Nix language server
    nixpkgs-fmt
    # nodePackages.prettier
    # prettierd
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint_d
    nodePackages.svelte-language-server
    nodePackages.vue-language-server
    # nodePackages.eslint
    shellcheck
    statix # Lints and suggestions for the nix programming language
  ];

  home.shellAliases = {
    vim = "nvim -p";
  };

  xdg.configFile =
    {
      "nvim" = {
        recursive = true;
        source = ./nvim;
      };
    };

    xdg.dataFile."nvim/site/pack/nix/start".recursive = true;
    xdg.dataFile."nvim/site/pack/nix/start".source = pkgs.linkFarmFromDrvs "neovim-plugins" (with pkgs.vimPlugins; [
      impatient-nvim # Speed up loading Lua modules in Neovim to improve startup time using caching

      # LSP
      nvim-lspconfig # Quickstart configs for Nvim LSP
      null-ls-nvim   # Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
      # lsp_extensions-nvim # archived
      nvim-lsputils # Better defaults for nvim-lsp actions

      nvim-lightbulb # 💡
      FixCursorHold-nvim # strongly recommended for nvim-lightbulb
      nvim-code-action-menu

      trouble-nvim # A pretty diagnostics, references, telescope results, quickfix and location list
      lspkind-nvim # vscode-like pictograms for neovim lsp completion items (works with LSP, CMP)
      lsp_signature-nvim # LSP signature hint as you type
      lsp-status-nvim # Utility functions for diagnostic status and progress messages from LSP servers, for use in the Neovim statusline
      # fidget-nvim # Standalone UI for nvim-lsp progress. Eye candy for the impatient.
      (fidget-nvim.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "j-hui";
          repo = "fidget.nvim";
          rev = "90c22e47be057562ee9566bad313ad42d622c1d3";
          hash = "sha256-N3O/AvsD6Ckd62kDEN4z/K5A3SZNR15DnQeZhH6/Rr0=";
        };
      }))

      nvim-treesitter
      nvim-navic # Simple winbar/statusline plugin that shows your current code context
      comment-nvim

      vimtex

      # Autocompletion
      luasnip # Snippet Engine for Neovim written in Lua.
      cmp_luasnip # luasnip completion source for nvim-cmp
      cmp-nvim-lua
      cmp-nvim-lsp
      cmp-vsnip
      cmp-path
      # cmp-emoji # useful on non macos systems
      # cmp-calc
      cmp-buffer # nvim-cmp source for buffer words
      cmp-nvim-lsp-signature-help # nvim-cmp source for displaying function signatures with the current parameter emphasized
      nvim-cmp # completion plugin for neovim written in Lua

      # Utils
      editorconfig-nvim # soon (0.9.0) redunant
      gitsigns-nvim # git integration for buffers
      hydra-nvim # Create custom submodes and menus (known from Emacs)
      indent-blankline-nvim # adds indentation guides to all lines (uses no conceal and nvims virtual text f)
      lualine-nvim # blazing fast and easy to configure Neovim statusline written in Lua
      neogit # magit for neovim
      nvim-notify # fancy, configurable, notification manager (floating windows)
      nvim-tree-lua # nvim-tree-lua
      telescope-nvim # Find, Filter, Preview, Pick. All lua, all the time (requires plenary-nvim)

      # vim classics
      vim-easy-align
      vim-fish
      vim-repeat
      vim-surround
      vim-unimpaired

      # Themes
      jellybeans-nvim
      lush-nvim # since jellybeans-nvim is built with this
      neovim-ayu
      nord-nvim
      onenord-nvim

      # Dependencies
      popfix # nvim-lsputils, telescope-nvim
      plenary-nvim # crates-nvim, telescope-nvim, gitsigns-nvim, neogit
      nvim-web-devicons

      headlines-nvim
    ] ++ (builtins.attrValues nvim-treesitter.grammarPlugins));


}
