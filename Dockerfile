# This must be built on an armv7l based machine like a raspberry pi
# based on debian testing
FROM debian@sha256:28400e7a767b47a933c2579383577243c22033fd3ebeea20239f9a0943701a35
RUN apt-get update && apt-get install -y nix git
RUN git clone https://github.com/nixos/nix
WORKDIR /nix
RUN git checkout 2.3.7
RUN echo "extra-substituters = https://thefloweringash-armv7.cachix.org" >> /etc/nix/nix.conf && \
    echo "http-connections = 5" >> /etc/nix/nix.conf && \
    echo "trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= thefloweringash-armv7.cachix.org-1:v+5yzBD2odFKeXbmC+OPWVqx4WVoIVO6UXgnSAWFtso=" >> /etc/nix/nix.conf
RUN nix-build -E "builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz" || true
RUN echo "system = armv7l-linux" >> /etc/nix/nix.conf
RUN nix-build release.nix -A binaryTarball --arg nixpkgs "builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz" --arg systems '["armv7l-linux"]' --show-trace || true
