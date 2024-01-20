let pkgs = import <nixpkgs> {};
in
{
  label = import ./label/label.nix pkgs;
  note = import ./note.nix pkgs;
}
