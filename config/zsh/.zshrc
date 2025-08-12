eval "$(starship init zsh)"

# Plugins {{{
# Sourcing {{{
# The most incredible of plugin managers: `plm.sh`!
for PLUGIN in $("$DOTFILES/scripts"/zsh_plm.sh list); do
	source "$PLUGIN" 2>/dev/null || source "$PLUGIN"
done
# }}}
# Configuration {{{
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# }}}
# }}}

# ZSH {{{
# Modules {{{
zmodload zsh/complist
autoload -U compinit; compinit


autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -Uz run-help
# }}}
# Options {{{
setopt AUTO_CD
setopt APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS

unsetopt BEEP

bindkey -v; KEYTIMEOUT=50

HISTFILE="$ZDOTDIR"/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# }}}
# Completer {{{
setopt globdots

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' menu search select

zstyle ':completion:*:descriptions' format '%F{yellow}:: %d%f'
zstyle ':completion:*:warnings' format "%F{red}no matches%f"
zstyle ':completion:*:corrections' format '%F{blue}:: %d%f (errors: %F{red}%e%f)'
zstyle ':completion:*' group-name ''

# Via compinstall
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' substitute 1
# }}}
# Bindings {{{
# Special keys {{{
function () {
	local ZKBD_ENV=$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
	local ZKBD_MAP=$ZDOTDIR/.zkbd/$ZKBD_ENV
	if [[ ! -f "$ZKBD_MAP" ]]; then
		echo "Warning: no zkbd map found for the current environment: $ZKBD_ENV"
		read -q "PROMPT?Run 'zkbd'? [y/N]: "
		if [[ $PROMPT == "y" ]]; then echo ""; autoload -Uz zkbd; zkbd; else return 0; fi
	fi

	source $ZKBD_MAP
	[[ -n "${key[Backspace]}"	]] && bindkey -- "${key[Backspace]}"	backward-delete-char
	[[ -n "${key[Insert]}"		]] && bindkey -- "${key[Insert]}"		overwrite-mode
	[[ -n "${key[Home]}"		]] && bindkey -- "${key[Home]}"			beginning-of-line
	[[ -n "${key[PageUp]}"		]] && bindkey -- "${key[PageUp]}"		beginning-of-buffer-or-history
	[[ -n "${key[Delete]}"		]] && bindkey -- "${key[Delete]}"		delete-char
	[[ -n "${key[End]}"			]] && bindkey -- "${key[End]}"			end-of-line
	[[ -n "${key[PageDown]}"	]] && bindkey -- "${key[PageDown]}"		end-of-buffer-or-history
	[[ -n "${key[Up]}"			]] && bindkey -- "${key[Up]}"			up-line-or-beginning-search
	[[ -n "${key[Left]}"		]] && bindkey -- "${key[Left]}"			backward-char
	[[ -n "${key[Down]}"		]] && bindkey -- "${key[Down]}"			down-line-or-beginning-search
	[[ -n "${key[Right]}"		]] && bindkey -- "${key[Right]}"		forward-char
}
# }}}
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search

bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history

bindkey "^\ " reverse-menu-complete

bindkey "^l" forward-word
bindkey "^h" backward-word
# }}}
# Environment variables {{{
export VISUAL="vim"
export SYSTEMD_EDITOR="$VISUAL"
#export BROWSER="elinks"

export FZF_DEFAULT_COMMAND="fd --type f"
export MANPAGER="less -R --use-color -Dd+y -Du+g"


export VIMINIT="source $DOTFILES/config/vim/vimrc"
export STARSHIP_CONFIG="$DOTFILES/config/starship.toml"

export RUSTUP_HOME="$XDG_DATA_HOME/rust/rustup"
export CARGO_HOME="$XDG_DATA_HOME/rust/cargo"

export PATH="$PATH:$DOTFILES/environment/path:$CARGO_HOME/bin"
# }}}
# Aliases {{{
alias ls="eza"
# The ls equivalent to --binary is --human-readable (-h)
alias l="ls -l --binary"
alias ll="l --almost-all"

alias se="sudoedit"


alias ssh="TERM=xterm-color ssh"
alias grep="rg --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"

alias vimpager="/usr/share/vim/vim91/macros/less.sh"

# Too finicky to be worth memorising
#if [[ "$TERM" == "xterm-kitty" ]]; then
#	alias ssh="kitty +kitten ssh"
#	alias icat="kitty +kitten icat"
#fi
# }}}
# Functions {{{
# (FILE...) | tries to copy FILE(s) to FILE.bak
bak() {
	if (($# == 0)); then printf 'Usage: %s FILE...\n' "$0"; fi
	for i; do
		DEST="$i".bak

		if [ -e "$DEST" ]; then
			1>&2 printf '%s: File exists\n' "$DEST"
		else
			cp "$i" "$DEST"
		fi
	done
}
# (FILE...) | tries to remove the last extension from FILE(s)
unbak() {
	if (($# == 0)); then printf 'Usage: %s FILE...\n' "$0"; fi
	for i; do
		DEST="${i%.*}"

		if [ -e "$DEST" ]; then
			1>&2 printf '%s: File exists\n' "$DEST"
		else
			mv "$i" "$DEST"
		fi
	done
}
# }}}
# }}}
# vim:set foldlevel=1:
