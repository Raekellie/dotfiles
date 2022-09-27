# Directories {{{
source "$HOME/.config/dotfiles/gui/environment.d/envvars.conf"
export ZDOTDIR="$DOTFILES/tui/zsh"
# }}}
# Preferences {{{
export VIMINIT="source $DOTFILES/tui/vim/vimrc"
export VISUAL="vim"
export EDITOR="vim"
export SYSTEMD_EDITOR="vim"
export BROWSER="elinks"

export STARSHIP_CONFIG="$DOTFILES/tui/starship.toml"


export FZF_DEFAULT_COMMAND="fd --type f"
export MANPAGER="less -R --use-color -Dd+y -Du+g"
# }}}
