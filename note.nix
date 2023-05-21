pkgs:
pkgs.stdenv.mkDerivation {
  name = "note";
  src = ./notes;
  buildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    cp $src/note.sh $out/lib/note.sh
    cp $src/notes-dir.sh $out/lib/notes-dir.sh
    sed -i "s|notes-dir.sh|$out/lib/notes-dir.sh|g" $out/lib/note.sh
    chmod 733 $out/lib/note.sh
    chmod 733 $out/lib/notes-dir.sh
    makeWrapper $out/lib/note.sh $out/bin/note --prefix PATH : ${pkgs.coreutils}
    makeWrapper $out/lib/notes-dir.sh $out/bin/notes-dir --prefix PATH : ${pkgs.coreutils}
  '';
}
