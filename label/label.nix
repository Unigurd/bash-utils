pkgs:
let
  lib = pkgs.lib;
  mkDerivation = pkgs.stdenv.mkDerivation;
  perl = pkgs.perl;
  coreutils = pkgs.coreutils;
in
mkDerivation {
  name = "label";
  src  = ./label.sh;
  completion = ./label-completion.sh;
  dontUnpack = true;
  buildInputs = [pkgs.makeWrapper];
  installPhase = ''
    mkdir -p "$out/bin"
    cp $src "$out/bin/gurd-label.sh"

    mkdir -p "$out"/etc/bash_completion.d
    cp "$completion" "$out"/etc/bash_completion.d/
'';
}
