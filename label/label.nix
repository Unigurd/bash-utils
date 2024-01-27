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
    mkdir -p "$out/lib"
    cp $src "$out/lib/gurd-label.sh"
    makeWrapper "$out/lib/gurd-label.sh" "$out/bin/gurd-label.sh" --prefix PATH : ${lib.makeBinPath [coreutils perl]}

    mkdir -p "$out"/etc/bash_completion.d
    cp "$completion" "$out"/etc/bash_completion.d/
'';
}
