#!/bin/bash

set -Eeu -o pipefail

if [ "$(id -u)" -eq 0 ] ; then
  echo "This script must not be run as root"
  exit 1
fi

if [ "$(command -v curl)x" == "x" ] ; then
  sudo apt update -qq &&
  sudo apt install -y --no-install-recommends curl ca-certificates
fi

if [ "$(command -v nix)x" == "x" ] ; then
  sh <(curl -L https://nixos.org/nix/install) --daemon --yes
  # shellcheck disable=SC1091
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager &&
nix-channel --update &&
nix-shell '<home-manager>' -A install

HOME_NIX="$(curl -SsL https://raw.githubusercontent.com/moritzheiber/nix-home/main/home.nix)"

if [ "$(echo "${HOME_NIX}" | wc -l)" -gt 1 ] ; then
  echo "${HOME_NIX}" > "${HOME}/.config/home-manager/home.nix"
fi

home-manager switch -b backup
