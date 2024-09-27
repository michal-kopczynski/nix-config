# Based on
https://github.com/dustinlyons/nixos-config

# Make sure the configuration builds
nix run .#build

# Deploy the configuratoin
nix run .#build-switch

# List generations
/run/current-system/sw/bin/darwin-rebuild --list-generations
