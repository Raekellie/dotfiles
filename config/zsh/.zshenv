# Directories {{{
# The XDG and DOTFILES variables are only set after this line, and thus the path is hardcoded
source "$HOME/.config/dotfiles/environment/environment.d/envvars.conf"
export ZDOTDIR="$DOTFILES/config/zsh"
# }}}
# Preferences {{{
export VIMINIT="source $DOTFILES/config/vim/vimrc"
export VISUAL="vim"
export EDITOR="vim"
export SYSTEMD_EDITOR="vim"
export STARSHIP_CONFIG="$DOTFILES/config/starship.toml"
#export BROWSER="elinks"


export FZF_DEFAULT_COMMAND="fd --type f"
export MANPAGER="less -R --use-color -Dd+y -Du+g"


export RUSTUP_HOME="$XDG_DATA_HOME/rust/rustup"
export CARGO_HOME="$XDG_DATA_HOME/rust/cargo"

export PATH="$PATH:$DOTFILES/environment/path:$CARGO_HOME/bin"
# }}}
