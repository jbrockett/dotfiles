if which docker > /dev/null; then
  alias docker-rmsc='docker rm -v $(docker ps -aq --filter "status=exited")'
  alias docker-rmui='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
  alias docker-rmuv='docker volume rm $(docker volume ls -qf dangling=true)'
fi

set -o vi
export EDITOR=vim

# MAC ONLY
# Add tab completion for bash completion 2
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

export PATH="/usr/local/sbin:$PATH"
