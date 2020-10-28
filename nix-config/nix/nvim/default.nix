# Borrowed from https://github.com/srid/nix-config/blob/master/nix/nvim/default.nix

{ pkgs ? import <nixpkgs> {}, ... }:


let
  # cf. https://nixos.wiki/wiki/Vim#Adding_new_plugins 
  customPlugins = {
  };
in
  with pkgs; neovim.override {
    viAlias = true;
    vimAlias = true;
    configure = {

      # Builtin packaging
      # List of plugins: nix-env -qaP -A nixos.vimPlugins
      packages.myVimPackage = with pkgs.vimPlugins; {
        # Loaded on launch
        start = [ ];
        # Manually loadable by calling `:packadd $plugin-name
        opt = [ ];
      };

      # VAM
      vam.knownPlugins = pkgs.vimPlugins // customPlugins;
      vam.pluginDictionaries = [
          { name = "lightline-vim"; }
          { name = "vim-nix"; }
      ];

      customRC = builtins.readFile ./config.vim; #  + builtins.readFile ./config-coc.vim;
    };
  }