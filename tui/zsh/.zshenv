# Directories {{{
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export DOTFILES="$XDG_CONFIG_HOME/dotfiles"
export ZDOTDIR="$DOTFILES/tui/zsh"

export PATH="$PATH:$DOTFILES/scripts/path:$HOME/.cargo/bin"
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

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp -Dswing.aatext=true'

export LANG="pt_PT.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
# }}}
