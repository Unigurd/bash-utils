pkgs:
let
  mkDerivation = pkgs.stdenv.mkDerivation;
in
mkDerivation {
  name = "label";
  src  = ./label.sh;
  completion = ./label-completion.sh;
  dontUnpack = true;
  installPhase = ''
    mkdir -p "$out/bin"
    cp $src "$out/bin/gurd-label.sh"

    mkdir -p "$out"/etc/bash_completion.d
    cp "$completion" "$out"/etc/bash_completion.d/
'';
}
