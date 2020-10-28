{ config, pkgs, ... }:

{
  # Permit non-free software
  nixpkgs.config.allowUnfree = true;
  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jdheyburn";
  home.homeDirectory = "/home/jdheyburn";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    # Track sources
    niv

    # Basic
    fzf     # fuzzy finder - cmd history search
    htop    # interactive process viewer
    jq      # json parser
    ncdu    # file browser
    unzip
    wget

    (callPackage ./nvim {})


  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
