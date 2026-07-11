set -g fish_greeting

# Abbrevations
# `alias` over `abbr --add` because abbreviations don't recurse
alias "nixalias"		"nixos-rebuild --sudo --flake $HOME/dev/nix/home.nix"
alias "nixalias-dev"	"nixalias --override-input dotfiles $HOME/dev/nix/dotfiles"
