pkgs:
let
  lib = pkgs.lib;
  mkDerivation = pkgs.stdenv.mkDerivation;
  perl = pkgs.perl;
  coreutils = pkgs.coreutils;
in
mkDerivation {
  pname = "label";
  version = "0.1";
  src  = ./label.sh;  # pkgs.substitute {src = ./label.sh; replacements = {"perl" = perl;};};
  completion = ./label-completion.sh;
  dontUnpack = true;
  installPhase = ''
    mkdir -p "$out/bin"
    substitute "$src" "$out/bin/gurd-label.sh" --replace perl "${perl}/bin/perl" \
               --replace ' ls ' ' ${coreutils}/bin/ls ' --replace cat ${coreutils}/bin/cat \
               --replace echo ${coreutils}/bin/echo --replace mkdir ${coreutils}/bin/mkdir

    mkdir -p "$out"/etc/bash_completion.d
    cp "$completion" "$out"/etc/bash_completion.d/
'';
}
