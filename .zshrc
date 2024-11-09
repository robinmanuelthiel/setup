# Only do the following if the shell is not running in VSCode to improve VS Code startup performace:
# see https://stackoverflow.com/questions/66162058/vscode-complains-that-resolving-my-environment-takes-too-long
if [[ "$VSCODE_PID" = "" ]]; then  
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # Set Theme to Powerlevel10k
  source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"

  # Uncomment the following line if pasting URLs and other text is messed up.
  DISABLE_MAGIC_FUNCTIONS=true

  # Set default user
  DEFAULT_USER="robinmanuelthiel"

  alias k=kubectl
  alias t=terraform
  alias c=clear
  alias nvm=fnm
  alias please='sudo $(fc -ln -1)'

  # Azure Account Switch
  alias az-eve="az account set -s 3f249652-ea72-46a9-b1b7-b654ee8f89d3 && az account show" 
  alias az-ms="az account set -s 45568880-3489-47ce-8fb7-95aeebf63120 && az account show"
  alias az-spaceblocks="az account set -s d906ba88-5844-44ed-a204-88b38c0a101c && az account show"

  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit

  # Highlight selection in menu completion
  zstyle ':completion:*' menu select

  # Azure auto-complete
  [ -s "$(brew --prefix)/etc/bash_completion.d/az" ] && \. "$(brew --prefix)/etc/bash_completion.d/az"

  # Kubectl auto-complete
  if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

  # The fuck
  eval $(thefuck --alias)

  # Option Keys
  bindkey '[C' forward-word
  bindkey '[D' backward-word

  # NVM (replaced by fnm)
  eval "$(fnm env --use-on-cd)"

  # Plugins
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  
  # fzf Key Bidnings
  source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
fi

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH=$PATH:/$HOME/.dapr/bin
export PATH=$PATH:/$HOME/.dotnet/tools
export PATH=$PATH:/$HOME/go/bin
export PATH=$PATH:/$HOME/.local/bin
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
