{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ------ developpement ------
    nodejs_22
    libgcc
    luarocks
    lua5_1
    cairo
    git
    gcc
    mysql80
    go
    python311
    php83Packages.composer
    nixfmt-rfc-style # format for the nix language
    nixd # lsp for nix
    rustc
    cargo
    nix-tree
    brightnessctl
    fprintd
    zip
    unzip
    steam-run
    /*
      gtk-layer-shell
      pango
      rubyPackages_3_3.gdk_pixbuf2
      rubyPackages_3_3.glib2
      glibc
    */
  ];
}
