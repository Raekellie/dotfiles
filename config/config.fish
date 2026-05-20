set -g fish_greeting

# Abbrevations
# `alias` over `abbr --add` because abbreviations don't recurse
alias "nixswitch"		"nixos-rebuild switch --sudo --flake $HOME/dev/nix/home.nix"
alias "nixswitch-dev"	"nixswitch --override-input dotfiles $HOME/dev/nix/dotfiles"
