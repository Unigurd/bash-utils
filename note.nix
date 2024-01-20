pkgs:
pkgs.stdenv.mkDerivation {
  name = "note";
  src = ./note;
  buildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    cp $src/note $out/lib/note
    cp $src/note-dir $out/lib/note-dir
    # sed -i "s|note-dir|$out/lib/note-dir|g" $out/lib/note
    chmod 555 $out/lib/note
    chmod 555 $out/lib/note-dir
    makeWrapper $out/lib/note $out/bin/note --prefix PATH : ${pkgs.coreutils}
    makeWrapper $out/lib/note-dir $out/bin/note-dir --prefix PATH : ${pkgs.coreutils}
  '';
}
