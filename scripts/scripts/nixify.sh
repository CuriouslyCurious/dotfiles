nixify() {
    if [ ! -e ./.envrc ]; then
        echo "use nix" > .envrc
        direnv allow
    fi
    if [ ! -e default.nix ]; then
        cat > default.nix <<'EOF'
with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    bashInteractive
  ];
}
EOF
    ${EDITOR:-vim} default.nix
    fi
}
