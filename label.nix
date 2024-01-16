pkgs:
let
  mkDerivation = pkgs.stdenv.mkDerivation;
  # To be piped into a file $out/bin/install-label.sh.
  # Adds coreutils to PATH if somehow not present
  # to ensure the script works.
  # OUT is substituted with whatever $out is.
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
  completion = ./label-completion.sh;
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/label.sh
    echo '${wrapper}' > $out/bin/install-label.sh
    sed -i "s|OUT|$out|g" "$out"/bin/install-label.sh

    mkdir -p "$out"/share/bash-completion/completions
    cp "$completion" "$out"/share/bash-completion/completions
'';
}
