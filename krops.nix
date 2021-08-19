let
  # https://tech.ingolf-wagner.de/nixos/krops/
  krops = builtins.fetchGit { url = "https://cgit.krebsco.de/krops/"; };
  lib = import "${krops}/lib";
  pkgs = import "${krops}/pkgs" { };

  source = lib.evalSource [{
    nixpkgs.git = {
      ref = "origin/nixos-21.05";
      url = "https://github.com/NixOS/nixpkgs";
    };

    nixos-config.file = toString ./configuration.nix;
    "hardware-configuration.nix".file = toString ./hardware-configuration.nix;
  }];
in
# bash -c '$(nix-build --no-out-link krops.nix)'
pkgs.krops.writeDeploy "hydev-linode" {
  source = source;
  target = "root@172.105.239.128";
}
