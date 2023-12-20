# Only do the following if the shell is not running in VSCode to improve VS Code startup performace:
# see https://stackoverflow.com/questions/66162058/vscode-complains-that-resolving-my-environment-takes-too-long
if [[ "$VSCODE_PID" = "" ]]; then  
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # If you come from bash you might have to change your $PATH.
  # export PATH=$HOME/bin:/usr/local/bin:$PATH

  # Path to your oh-my-zsh installation.
  export ZSH="/Users/robinmanuelthiel/.oh-my-zsh"

  # Set name of the theme to load --- if set to "random", it will
  # load a random theme each time oh-my-zsh is loaded, in which case,
  # to know which specific one was loaded, run: echo $RANDOM_THEME
  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
  #ZSH_THEME="robbyrussell"
  #ZSH_THEME="agnoster"
  source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" # Set Theme to Powerlevel10k

  # Set list of themes to pick from when loading at random
  # Setting this variable when ZSH_THEME=random will cause zsh to load
  # a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
  # If set to an empty array, this variable will have no effect.
  # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

  # Uncomment the following line to use case-sensitive completion.
  # CASE_SENSITIVE="true"

  # Uncomment the following line to use hyphen-insensitive completion.
  # Case-sensitive completion must be off. _ and - will be interchangeable.
  # HYPHEN_INSENSITIVE="true"

  # Uncomment the following line to disable bi-weekly auto-update checks.
  # DISABLE_AUTO_UPDATE="true"

  # Uncomment the following line to automatically update without prompting.
  # DISABLE_UPDATE_PROMPT="true"

  # Uncomment the following line to change how often to auto-update (in days).
  # export UPDATE_ZSH_DAYS=13

  # Uncomment the following line if pasting URLs and other text is messed up.
  DISABLE_MAGIC_FUNCTIONS=true

  # Uncomment the following line to disable colors in ls.
  # DISABLE_LS_COLORS="true"

  # Uncomment the following line to disable auto-setting terminal title.
  # DISABLE_AUTO_TITLE="true"

  # Uncomment the following line to enable command auto-correction.
  # ENABLE_CORRECTION="true"

  # Uncomment the following line to display red dots whilst waiting for completion.
  # COMPLETION_WAITING_DOTS="true"

  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories
  # much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  # Uncomment the following line if you want to change the command execution time
  # stamp shown in the history command output.
  # You can set one of the optional three formats:
  # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
  # or set a custom format using the strftime function format specifications,
  # see 'man strftime' for details.
  # HIST_STAMPS="mm/dd/yyyy"

  # Would you like to use another custom folder than $ZSH/custom?
  # ZSH_CUSTOM=/path/to/new-custom-folder

  # Which plugins would you like to load?
  # Standard plugins can be found in ~/.oh-my-zsh/plugins/*
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  source $ZSH/oh-my-zsh.sh
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  # source "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh" # Not needed, because integrated in Powerleve10k
  # source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Not needed, because integrated in Powerleve10k

  plugins=(
      git
      fzf
  )  

  # User configuration

  # export MANPATH="/usr/local/man:$MANPATH"
  DEFAULT_USER="robinmanuelthiel"

  # You may need to manually set your language environment
  # export LANG=en_US.UTF-8

  # Preferred editor for local and remote sessions
  # if [[ -n $SSH_CONNECTION ]]; then
  #   export EDITOR='vim'
  # else
  #   export EDITOR='mvim'
  # fi

  # Compilation flags
  # export ARCHFLAGS="-arch x86_64"

  # Set personal aliases, overriding those provided by oh-my-zsh libs,
  # plugins, and themes. Aliases can be placed here, though oh-my-zsh
  # users are encouraged to define aliases within the ZSH_CUSTOM folder.
  # For a full list of active aliases, run `alias`.
  #
  # Example aliases
  # alias zshconfig="mate ~/.zshrc"
  # alias ohmyzsh="mate ~/.oh-my-zsh"
  alias k=kubectl
  alias t=terraform
  alias c=clear
  alias nvm=fnm

  # Azure Account Switch
  alias az-eve="az account set -s 781b01b5-9d47-4b4a-bcdd-b24d9f479fd2 && az account show" 
  alias az-eve2="az account set -s f3957873-3134-4def-9380-b93ad9d4a935 && az account show"
  alias az-ms="az account set -s 0ec6dbb0-b89b-4bb3-9140-14e3d244e0ee && az account show"
  alias az-ms2="az account set -s f176cb8a-43d5-4490-9d2b-5ef5fcb7bf95 && az account show"
  alias az-wemogy="az account set -s 0dce37d2-715f-42a8-8297-7b3b30382521 && az account show"
  alias az-wemogy-test="az account set -s 0b05fa67-dd74-4ed1-9d85-d1a04b6e4c33 && az account show"

  # Azure auto-complete
  source /usr/local/etc/bash_completion.d/az

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
  # export NVM_DIR="$HOME/.nvm"
  # [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
  # [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && \. "/usr/local/opt/nvm/etc/bash_completion"

  # Krew
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
  export PATH="/usr/local/opt/node@12/bin:$PATH"
  export PATH=$PATH:/$HOME/.dapr/bin
  export PATH=$PATH:/$HOME/.dotnet/tools
fi
