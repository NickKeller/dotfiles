# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="nickkeller"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13
zstyle ':omz:update' verbose silent

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

alias ll="ls -lah"
alias vim="nvim"
alias vi="nvim"
alias rp="cd ~/go/src/aks-rp"
alias lg="az login -o none && systemctl --user enable --now goproxy.timer"

export PATH=$PATH:/usr/local/go/bin:/home/azureuser/go/bin:/home/azureuser/.local/bin:/home/azureuser/go/src/aks-rp/bin:/opt/nvim-linux64/bin:$HOME/.tmuxifier/bin:$HOME/work/mgmt-Governance-Policy/kubernetes-policy-e2e/tools/
export DEVSUB="c1089427-83d3-4286-9f35-5af546a6eb67"
export TESTSUB="8ecadfc9-d1a3-4ea4-b844-0d9f87e4d7c8"
export STAGINGSUB="26fe00f8-9173-4872-9134-bb1d2e00343a"
# export AKS_GOPROXY_TOKEN=picp4gbkuvnhl2yo3tmpsbscdmivvtu42hbbachkj2wwuv4qnu2a
# export VSTS_PAT=5kgftzpqkvwczrnf2btkw7mvvnzo23hk6hkdxsvhmpiypkwczpga
# export GOPROXY="https://nikelle:$AKS_GOPROXY_TOKEN@goproxyprod.goms.io"
# export GOPRIVATE="goms.io/aks/*,go.goms.io/aks/*,go.goms.io/fleet*"
# export GONOPROXY=none
export GOROOT=/usr/local/go/
export GOPATH=/home/azureuser/go/

export ENABLE_AKS_GOPROXY_AAD_AUTH=true
export EDITOR="nvim"

export TMUXIFIER="/home/azureuser/.tmuxifier";
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"
source "$TMUXIFIER/init.sh";

export GOPROXY="https://goproxyprod.goms.io"
export GOPRIVATE="goms.io/aks/*,go.goms.io/aks/*,go.goms.io/caravel,go.goms.io/fleet*"
export GONOPROXY=none
export __AKS_DOCKER_BUILD_MOUNT_NETRC=1  # Set this so that container builds work with your .netrc

function jwtd() {
    if [[ -x $(command -v jq) ]]; then
         jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "${1}"
         echo "Signature: $(echo "${1}" | awk -F'.' '{print $3}')"
    fi
}

function aksb() {
    mv go.work go.work.backup
    mv go.work.sum go.work.sum.backup
 
    echo "Running ./hack/aksbuilder.sh $1 -w ${@[2,-1]}"
    ./hack/aksbuilder.sh $1 -w "${@[2,-1]}"
    local ec=$?
 
    mv go.work.backup go.work
    mv go.work.sum.backup go.work.sum

    return $ec
}

function rf() {
    source ~/.zshrc
}

function latest_tag {
    git describe --tags $(git rev-list --tags --max-count=5000) | grep $1 | grep -v -E '\-.*$' | sort | tail -n 1
}


# if dbus is not running start it
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    dbus-run-session -- zsh 
fi


# Only run if DBUS is running and gnome-keyring-daemon is not
if [ -n "$DBUS_SESSION_BUS_ADDRESS" ] && [ -z "$SSH_AUTH_SOCK" ]; then
    # Prompt the user for the keyring password
    # Unlock the gnome-keyring-daemon with the provided password
    echo -n "B3rw1ckF4rmDr!" | gnome-keyring-daemon --unlock
fi

function make(){
    mv go.work go.work.backup
    mv go.work.sum go.work.sum.backup
    
    echo "make ${@[1,-1]}"
    /usr/bin/make ${@[1,-1]}
    local ec=$?

    mv go.work.backup go.work
    mv go.work.sum.backup go.work.sum

    return $ec
}
