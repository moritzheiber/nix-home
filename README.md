# Machine Provisioning with Nix and Home Manager

## Initial setup

1. Installing Nix:

```console
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
```

2. Installing Home Manager:

```console
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
nix-channel --update && \
nix-shell '<home-manager>' -A install
```

3. Copy `home.nix` into the right location
4. Let `home-manager` do its thing:

```console
home-manager switch -b backup
```
