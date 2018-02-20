# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export PATH=/Users/kooparse/.local/bin/luna-studio:$PATH
export ZSH=/Users/kooparse/.oh-my-zsh
export DEV=/Users/kooparse/Documents/dev
export RUST_SRC_PATH=$HOME/.cargo/bin/rustc
export EDITOR='vim'

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
)

autoload -U compinit
compinit

source $HOME/.cargo/bin
source $(brew --prefix)/etc/profile.d/z.sh
source $DEV/payfit/stack/.zshrc
source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias config='/usr/bin/git --git-dir=/Users/kooparse/.cfg/ --work-tree=/Users/kooparse'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

