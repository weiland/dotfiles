{ config
, pkgs
, lib
, ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  home.packages = with pkgs; [
    neovim-nightly
    lua51Packages.mpack

    nil
    shellcheck

    statix
    nixpkgs-fmt
    gitlint
    hadolint
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

  xdg.dataFile."nvim/site/pack/nix/start" = {
    recursive = true;
    source = pkgs.linkFarmFromDrvs "neovim-plugins" (with pkgs.vimPlugins; [
      impatient-nvim

      # LSP
      nvim-lspconfig
      null-ls-nvim
      lsp_extensions-nvim
      nvim-lsputils
      nvim-lightbulb
      FixCursorHold-nvim
      trouble-nvim
      nvim-code-action-menu
      lspkind-nvim
      lsp_signature-nvim
      lsp-status-nvim
      fidget-nvim

      # Treesitter
      (nvim-treesitter.overrideAttrs (_: {
        postPatch =
          let
            grammars = pkgs.tree-sitter.withPlugins (ps: (_: nvim-treesitter.allGrammars) (ps // builtGrammars));
          in
          ''
            rm -r parser
            ln -s ${grammars} parser
          '';
      }))
      nvim-navic
      spellsitter-nvim
      comment-nvim

      # Autocompletion
      luasnip
      cmp_luasnip

      cmp-nvim-lua
      cmp-nvim-lsp
      cmp-vsnip
      cmp-path
      cmp-emoji
      cmp-calc
      cmp-buffer
      cmp-nvim-lsp-signature-help
      nvim-cmp

      # Utils
      hydra-nvim
      indent-blankline-nvim
      nvim-notify
      telescope-nvim
      lualine-nvim
      gitsigns-nvim
      editorconfig-nvim
      lush-nvim
      jellybeans-nvim
      neogit
      nvim-tree-lua

      vim-easy-align
      vim-unimpaired
      vim-surround
      vim-repeat
      vim-fish

      # Dependencies
      popfix # nvim-lsputils, telescope-nvim
      plenary-nvim # crates-nvim, telescope-nvim, gitsigns-nvim, neogit
      nvim-web-devicons
    ]);
  };
}