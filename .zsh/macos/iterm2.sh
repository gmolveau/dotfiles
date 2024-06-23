ITERM2_PLUGIN="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/iterm2_shell_integration.zsh"
if [ ! -f "${ITERM2_PLUGIN}" ]; then
    echo "zsh iterm2 plugin not found"
    echo "download it via :"
    # shellcheck disable=SC2016
    echo 'curl -L https://iterm2.com/shell_integration/zsh -o "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/iterm2_shell_integration.zsh"'
else
    source "${ITERM2_PLUGIN}"
fi

# Specify the preferences directory
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "${HOME}/.config/iterm2/config"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true
