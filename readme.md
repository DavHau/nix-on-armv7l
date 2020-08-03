# Nix without NixOS on arm32v7 / armv7l / Raspberry Pi OS / Raspbian
This repo aims to provide a simple way of installing the nix package manager on any armv7l linux system which is not running NixOS

The nix release tarball used in the following guide has been built with docker on an existing armv7l system.
The Dockerfile is included.

## Quick install

To  download, unpack and install nix, execute the following command as non-root user:

  ```bash
  mkdir -p /tmp/nix-install && \
      cd /tmp/nix-install && \
      curl https://raw.github... | tar x && \
      cd nix-* &&\
      ./install-multi-user
  ```
After the installation log out and log in once, to make nix available.

## Add binary Cache
Nix is not very useful without a binary cache. Since the official cache.nixos.org doesn't provide binaries for armv7l, we need to add an alternative cache before the fun can begin.
A list of community maintained binary caches can be found on the nixos wiki page for [NixOS on ARM](https://nixos.wiki/wiki/NixOS_on_ARM)
At the time of writing, [a cache matintained by thefloweringash](https://app.cachix.org/cache/thefloweringash-armv7) is available.  

To add the cache, execute:
```bash
echo "extra-substituters = https://thefloweringash-armv7.cachix.org" >> /etc/nix/nix.conf
```

We also need to trust the signing keys of this cache.  
Since we are overwriting the defaults with this setting, we also need to include the signing keys for the official nixos cache.
```bash
echo "trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= thefloweringash-armv7.cachix.org-1:v+5yzBD2odFKeXbmC+OPWVqx4WVoIVO6UXgnSAWFtso=" >> /etc/nix/nix.conf
```

Ready to go! Have fun with nix!
