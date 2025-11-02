HISTFILE="$HOME/.config/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt HIST_IGNORE_ALL_DUPS

alias edit_ghostty="cd $HOME/.config/ghostty/ && nvim ."
alias edit_hyprland="cd $HOME/.config/hypr/ && nvim ."
alias edit_neovim="cd $HOME/.config/nvim/ && nvim ."

# On Debian systems the command for `bat` is `batcat` to prevent 
# a clash with an existing package, however I have confirmed that there is no
# other `bat` command in the container, so this is safe to use.
alias bat="batcat"

# lsd will be used instead of the regular ls command
alias ls="lsd"

# starship
eval "$(starship init zsh)"

# ZSH Autosuggestions
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    ZSH_AUTOSUGGEST_USE_ASYNC=true
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ZSH Syntax Highlighting
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
