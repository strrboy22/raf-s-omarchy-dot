# Source the plugins you just installed
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize Starship (for the colorful bubbles/icons)
eval "$(starship init zsh)"

# Correct Ghostty Shell Integration for Zsh on Arch
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
elif [[ -f "/usr/share/ghostty/shell-integration/zsh/ghostty-integration" ]]; then
    source "/usr/share/ghostty/shell-integration/zsh/ghostty-integration"
fi

clear
fastfetch

export PATH=$PATH:/home/rafael/.spicetify
export PATH="$HOME/.local/bin:$PATH"

