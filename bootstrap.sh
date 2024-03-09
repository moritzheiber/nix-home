#!/bin/bash

set -Eeu -o pipefail

NIX_CONF="https://raw.githubusercontent.com/moritzheiber/nix-home/main/nix.conf"
CONFIG_NIX="https://raw.githubusercontent.com/moritzheiber/nix-home/main/config.nix"
HOME_NIX="https://raw.githubusercontent.com/moritzheiber/nix-home/main/home.nix"

function download() {
  local url
  local destination
  local content

  url="${1}"
  destination="${2}"
  content="$(curl -SsL "${url}")"

  if [ "$(echo "${content}" | wc -l)" -gt 1 ] ; then
    echo "${content}" > "${destination}"
  fi
}

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

mkdir -p "${HOME}"/.config/{nix,nixpkgs,home-manager} &&
download "${NIX_CONF}" "${HOME}/.config/nix/nix.conf" &&
download "${CONFIG_NIX}" "${HOME}/.config/nixpkgs/config.nix" &&
download "${HOME_NIX}" "${HOME}/.config/home-manager/home.nix"

home-manager switch -b backup
