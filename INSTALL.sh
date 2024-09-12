#!/bin/bash

set -eu -o pipefail

# Make sure user is not using zsh or non-POSIX-mode bash, which can cause issues
verify_shell_is_posix_or_exit() {
  if [ -n "${ZSH_VERSION+x}" ]; then
    error "Running installation script with \`zsh\` is known to cause errors."
    error "Please use \`sh\` instead."
    exit 1
  elif [ -n "${BASH_VERSION+x}" ] && [ -z "${POSIXLY_CORRECT+x}" ]; then
    error "Running installation script with non-POSIX \`bash\` may cause errors."
    error "Please use \`sh\` instead."
    exit 1
  else
    true  # No-op: no issues detected
  fi
}

# Currently supporting:
#   - win (Git Bash)
#   - darwin
#   - linux
#   - linux_musl (Alpine)
#   - freebsd
detect_platform() {
  platform="$(uname -s | tr '[:upper:]' '[:lower:]')"

  case "${platform}" in
    msys_nt*) platform="pc-windows-msvc" ;;
    cygwin_nt*) platform="pc-windows-msvc";;
    # mingw is Git-Bash
    mingw*) platform="pc-windows-msvc" ;;
    # use the statically compiled musl bins on linux to avoid linking issues.
    linux) platform="unknown-linux-musl" ;;
    darwin) platform="apple-darwin" ;;
    freebsd) platform="unknown-freebsd" ;;
  esac

  printf '%s' "${platform}"
}

# Currently supporting:
#   - x86_64
#   - i386
#   - arm
#   - arm64
detect_arch() {
  arch="$(uname -m | tr '[:upper:]' '[:lower:]')"

  case "${arch}" in
    amd64) arch="x86_64" ;;
    armv*) arch="arm" ;;
    arm64) arch="aarch64" ;;
  esac

  # `uname -m` in some cases mis-reports 32-bit OS as 64-bit, so double check
  if [ "${arch}" = "x86_64" ] && [ "$(getconf LONG_BIT)" -eq 32 ]; then
    arch=i686
  elif [ "${arch}" = "aarch64" ] && [ "$(getconf LONG_BIT)" -eq 32 ]; then
    arch=arm
  fi

  printf '%s' "${arch}"
}

detect_target() {
  arch="$1"
  platform="$2"
  target="$arch-$platform"

  printf '%s' "${target}"
}

require() {
  if [[ -z $(command -v $1 2>/dev/null) ]]; then
    echo " 🛑  Please install $1 and try again"
    exit 1
  fi
}

# defaults
if [ -z "${PLATFORM-}" ]; then
  PLATFORM="$(detect_platform)"
fi

if [ -z "${ARCH-}" ]; then
  ARCH="$(detect_arch)"
fi

if [ -z "${TARGET-}" ]; then
  TARGET="$(detect_target "${ARCH}" "${PLATFORM}")"
fi

main() {
  # Non-POSIX shells can break once executing code due to semantic differences
  verify_shell_is_posix_or_exit

  require brew
  require node
  require npm

  brew install --cask android-studio
  brew install --cask nikitabobko/tap/aerospace
  brew install openjdk

  # Java Environment Variables
  # export JAVA_HOME="$(/usr/libexec/java_home -v 11)"
  # export PATH="$PATH:$JAVA_HOME/bin"

  brew install lua
  brew install lua-language-server
  brew install fzf

  # Set up fzf key bindings and fuzzy completion
  # eval "$(fzf --bash)"

  brew install starship
  brew install neovim
  brew install tmux
  brew install tmuxinator

  npm install -g typescript-language-server typescript
}

main
