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
    cp $src/note-grep $out/lib/note-grep
    cp $src/note-list $out/lib/note-list
    makeWrapper $out/lib/note $out/bin/note --prefix PATH : ${pkgs.coreutils}
    makeWrapper $out/lib/note-dir $out/bin/note-dir --prefix PATH : ${pkgs.coreutils}
    makeWrapper $out/lib/note-grep $out/bin/note-grep --prefix PATH : ${pkgs.coreutils} --prefix PATH : ${pkgs.gnused}
    makeWrapper $out/lib/note-list $out/bin/note-list --prefix PATH : ${pkgs.coreutils}

    # bash completion
    mkdir -p "$out/etc/bash_completion.d"
    cp "$src/note-completion.sh" "$out/etc/bash_completion.d"
  '';
}
