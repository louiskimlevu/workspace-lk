# detect the machine we're running on
# assume linux is wsl on windows (although any ubuntu should be ok)
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# set options for zsh
set -o noclobber

# load the universal env vars
source ~/.zsh/universal-envvars.zsh

# now load the aliases and and other customizations
[[ -f ~/.zsh/universal-aliases.zsh ]] && source ~/.zsh/universal-aliases.zsh

# Antige: load antigen plugin manager
if [ "$machine" = "Mac" ]; then
  source $(brew --prefix)/share/antigen/antigen.zsh
else
  source ~/antigen.zsh
fi

# Now load our custom plugins and config for antigen
[[ -f ~/.zsh/universal-antigen.zsh ]] && source ~/.zsh/universal-antigen.zsh

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

if [ "$machine" = "Mac" ]; then
  source ~/.zsh/mac-aliases.zsh
  # load fzf autocompletion and key bindings
  source ~/.zsh/mac-fzf.zsh
else
  source ~/.zsh/wsl-aliases.zsh
  source ~/.zsh/wsl-startagent.zsh
  source "$HOME/.homesick/repos/homeshick/homeshick.sh" # homebrew does this on mac
fi
