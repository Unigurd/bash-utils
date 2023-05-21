pkgs:
let
  mkDerivation = pkgs.stdenv.mkDerivation;
  wrapper = ''
    exists() {
      type "$1" >/dev/null 2>/dev/null
    }

    if exists mkdir && exists cat && exists echo
    then true
    else PATH="${pkgs.coreutils}/bin:$PATH"
    fi

    source OUT/label.sh
  '';

in
mkDerivation {
  name = "label";
  src  = ./label.sh;
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/label.sh
    echo '${wrapper}' > $out/bin/install-label.sh
    sed -i "s|OUT|$out|g" "$out"/bin/install-label.sh
'';
}
