#!/usr/bin/env bash

set -e

PACKAGES=(
  fzf
  htop
  stow
  z
)

FOLDERS=(
  bash
  fzf
  git
)

install_packages() {
  echo ""
  echo "Install packages: ${PACKAGES[@]}"

  brew install ${PACKAGES[@]}
}

install_homebrew() {
  echo ""
  echo "Install homebrew..."

  machine="$(uname -s)"
  case "${machine}" in
    Darwin*)
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      ;;
    
    Linux*)
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
      ;;
    
    *)
      echo "Unknown OS. Cannot continue."
      exit 1
  esac
}

install_composer() {
  echo ""
  echo "Install composer..."

  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php --install-dir=$HOME/bin --filename=composer
  php -r "unlink('composer-setup.php');"
}

link_folders() {
  echo ""
  echo "Link folders: ${FOLDERS[@]}"

  stow ${FOLDERS[@]}
}
main() {
  # create local bin dir
  [ -d "$HOME/bin" ] || mkdir $HOME/bin
  
  # install homebrew if it's missing
  if ! hash brew 2>/dev/null; then
    install_homebrew
  fi

  # install composer if it's missing
  if ! hash composer 2>/dev/null; then
    install_composer
  fi

  # install needed packages
  install_packages

  # links folders
  link_folders
}

main