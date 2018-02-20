## Install

Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:
- `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:
- `echo ".cfg" >> .gitignore`

Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:
- `git clone --bare <git-repo-url> $HOME/.cfg`

Define the alias in the current shell scope:
- `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

Checkout the actual content from the bare repository to your $HOME:
- `config checkout`

The step above might fail, if so:
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

Re-run the check out if you had problems:
- `config checkout`

Set the flag showUntrackedFiles to no on this specific (local) repository:
- `config config --local status.showUntrackedFiles no`

You're done.
