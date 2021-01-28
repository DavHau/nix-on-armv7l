## Nix without NixOS on arm32v7 / armv7l / Raspberry Pi OS / Raspbian
This repo aims to provide a simple way of installing the nix package manager on any armv7l linux system which is not running NixOS

The nix release tarball used in the following guide has been built with docker on an existing armv7l system.
The Dockerfile is included.

## Quick install

To  download, unpack and install nix, execute the following command as non-root user:

  ```bash
  apt-get update && \
      apt-get install -y curl xz-utils && \
      mkdir -p /tmp/nix-install && \
      cd /tmp/nix-install && \
      curl -L https://github.com/DavHau/nix-on-armv7l/releases/download/2.3.7-armv7l/nix-2.3.7pre0_0000000-armv7l-linux.tar.xz | tar xJ && \
      cd nix-* &&\
      ./install
  ```
If you prefer a multi user installation replace the last line with `./install-multi-user`.  
After the installation log out and log in once, to make nix available.

## Add binary Cache
Nix is not very useful without a binary cache. Since the official cache.nixos.org doesn't provide binaries for armv7l, we need to add an alternative cache before the fun can begin.
A list of community maintained binary caches can be found on the nixos wiki page for [NixOS on ARM](https://nixos.wiki/wiki/NixOS_on_ARM)
At the time of writing, [a cache matintained by thefloweringash](https://app.cachix.org/cache/thefloweringash-armv7) is available.  

To add the cache, execute (as copied from https://app.cachix.org/cache/thefloweringash-armv7):
```bash
nix-env -iA cachix -f https://cachix.org/api/v1/install
cachix use thefloweringash-armv7
```

Ready to go! Have fun with nix!
