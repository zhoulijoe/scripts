export PATH=/usr/local/bin:$PATH

# Include user bin
if [ -d ~/bin ]; then
    export PATH=$PATH:~/bin
fi

# Include android platform tools
if [ -d ~/Library/Android/sdk ]; then
    export ANDROID_HOME=~/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
fi

# Homebrew cask installs should get linked in /Applications instead of ~/Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Enable bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Load nvm
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Initialize pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Increase max open file and max stack size
ulimit -n 2048
ulimit -s 65532

# Set prompt format user@host:dir$
export PS1="\[\033[m\]\u\[\033[m\]@\[\033[m\]\h:\[\033[33;36m\]\w\[\033[m\]\$ "

# Make ls result colorful
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Allow npm to install global package without sudo
export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Alias
## ls
alias ls="ls -Fh"
alias ll="ls -laFh"
# Set default editor
export EDITOR="emacs"
## use GNU version of readlink
alias readlink="greadlink"
## launch xcode from CLI
alias xcode="open -a Xcode"

## java home
export JAVA_VERSION="1.8"
export JAVA_OPTS=-Dfile.encoding=UTF-8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/zhou/.gvm/bin/gvm-init.sh" ]] && source "/Users/zhou/.gvm/bin/gvm-init.sh"

# rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
