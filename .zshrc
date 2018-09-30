# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/kooparse/.oh-my-zsh
export DEV=/Users/kooparse/Documents/dev
export KITTY_CONFIG_DIRECTORY=~/.kitty.conf
export EDITOR="nvim"
export VISUAL="nvim"

# Vi mode
bindkey -v

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lambda"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git,
  zsh-completions,
  cargo,
  brew,
  z,
  zsh-syntax-highlighting,
  vim-mode,
)

autoload -U compinit
compinit

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line


source $HOME/.cargo/env
source $(brew --prefix)/etc/profile.d/z.sh
source $ZSH/oh-my-zsh.sh

# Example aliases
alias config='/usr/bin/git --git-dir=/Users/kooparse/.cfg/ --work-tree=/Users/kooparse'
alias e=$EDITOR

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

