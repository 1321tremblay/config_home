
# ---- P10K ----
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- VARIABLES ----
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export EDITOR=nvim

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/go/bin:$PATH"




# ---- ZINIT ----
ZINIT_HOME=$XDG_DATA_HOME/zinit/zinit.git
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"


zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo

# Load completions
autoload compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
autoload -U compinit && compinit

zinit cdreplay -q

# ---- P10K ----
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${ZDOTDIR:-~}/.p10k.zsh ]] || source ${ZDOTDIR:-~}/.p10k.zsh

# ---- KEYBINDINGS ----
bindkey -e
bindkey "^p" history-search-backward 
bindkey "^n" history-search-forward
bindkey -s ^h "tmux-sessionizer\n"

# ---- HISTORY ----
HISTSIZE=5000
export HISTFILE="$XDG_STATE_HOME"/zsh/history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ---- FZF ----
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#111111
  --color=hl:#458588,hl+:#83a598,info:#afaf87,marker:#98971a
  --color=prompt:#cc241d,spinner:#b16286,pointer:#b16286,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆"
  --separator="─" --scrollbar="│" --info="right"'

# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
#     --color=fg:-1,bg:-1,hl:#458588
#     --color=fg+:#ebdbb2,bg+:#111111,hl+:#83a598
#     --color=info:#afaf87,prompt:#cc241d,pointer:#b16286
#     --color=marker:#98971a,spinner:#b16286,header:#83a598"

	#    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
	# --color=fg:#908caa,bg:#191724,hl:#ebbcba
	# --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	# --color=border:#403d52,header:#31748f,gutter:#191724
	# --color=spinner:#f6c177,info:#9ccfd8
	# --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
export FZF_CTRL_R_OPTS="--no-preview --layout=reverse"


# ---- COMPLETION ----
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ---- FZF-TAB ----
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --preview-window=right:50%:border-left

# ---- NVM ----
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nv

# ---- ALIASES ----
alias ls="eza --icons=always -1 -a --git"
alias nix-shell="nix-shell --command zsh"
# alias v="nvim"
alias t="tmux"

alias v='NVIM_APPNAME=nvim nvim'

alias mini='NVIM_APPNAME=neorg nvim'


alias ts="$HOME/.local/bin/tmux-sessionizer.sh"

alias f="fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:50%:border-left --bind 'enter:execute(nvim {})'"





#---- BAT ----
export BAT_THEME=gruvbox-dark


eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(tux completion zsh)"

. "$HOME/.local/share/../bin/env"
. "/home/olivier/.deno/env"
# pnpm
export PNPM_HOME="/home/olivier/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
