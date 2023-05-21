let pkgs = import <nixpkgs> {};
in
{
  label = import ./label.nix pkgs;
  note = import ./note.nix pkgs;
}
