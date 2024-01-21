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
    cp $src/note-dir $out/lib/note-grep
    makeWrapper $out/lib/note $out/bin/note --prefix PATH : ${pkgs.coreutils}
    makeWrapper $out/lib/note-dir $out/bin/note-dir --prefix PATH : ${pkgs.coreutils}
    makeWrapper $out/lib/note-grep $out/bin/note-grep --prefix PATH : ${pkgs.coreutils}
  '';
}
