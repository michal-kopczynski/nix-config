.PHONY: build
build:
	# Build configuration
	nix run .#build
	# Activate configuration
	nix run .#build-switch
