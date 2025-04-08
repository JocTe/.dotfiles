#!/usr/bin/env bash

# Set script to be executable by default
[ "${BASH_SOURCE[0]}" = "$0" ] && chmod +x -- "$0"

echo '
   $$$$$\                  $$$$$$$$\      $$\               $$$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$$$\ $$$$$$\ $$\       $$$$$$$$\  $$$$$$\
   \__$$ |                 \__$$  __|     $  |              $$  __$$\ $$  __$$\\__$$  __|$$  _____|\_$$  _|$$ |      $$  _____|$$  __$$\
      $$ | $$$$$$\   $$$$$$$\ $$ | $$$$$$\\_/$$$$$$$\       $$ |  $$ |$$ /  $$ |  $$ |   $$ |        $$ |  $$ |      $$ |      $$ /  \__|
      $$ |$$  __$$\ $$  _____|$$ |$$  __$$\ $$  _____|      $$ |  $$ |$$ |  $$ |  $$ |   $$$$$\      $$ |  $$ |      $$$$$\    \$$$$$$\
$$\   $$ |$$ /  $$ |$$ /      $$ |$$$$$$$$ |\$$$$$$\        $$ |  $$ |$$ |  $$ |  $$ |   $$  __|     $$ |  $$ |      $$  __|    \____$$\
$$ |  $$ |$$ |  $$ |$$ |      $$ |$$   ____| \____$$\       $$ |  $$ |$$ |  $$ |  $$ |   $$ |        $$ |  $$ |      $$ |      $$\   $$ |
\$$$$$$  |\$$$$$$  |\$$$$$$$\ $$ |\$$$$$$$\ $$$$$$$  |      $$$$$$$  | $$$$$$  |  $$ |   $$ |      $$$$$$\ $$$$$$$$\ $$$$$$$$\ \$$$$$$  |
 \______/  \______/  \_______|\__| \_______|\_______/       \_______/  \______/   \__|   \__|      \______|\________|\________| \______/
 '


# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Homebrew is installed
if ! command_exists brew; then
    echo "🍺 Homebrew is not installed. Installing Homebrew..."

    # Check if running on macOS or Linux
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS installation
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for Apple Silicon Macs if needed
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
      echo 'not supported on linux currently'
        # # Linux installation
        # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # # Add Homebrew to PATH for Linux
        # test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
        # test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    echo "✅ Homebrew installed successfully!"
else
    echo "✅ Homebrew is already installed"
    # Update Homebrew to latest version
    echo "🔄 Updating Homebrew..."
    brew update
fi


# Create Brewfile if it doesn't exist
if [ ! -f "Brewfile" ]; then
    echo -e "\n📦 Creating Brewfile..."
    cat > Brewfile << EOF

# Essential packages
brew "git"
brew "wget"
brew "curl"
brew "jq"
brew "openssl"
brew "stow"
brew "cocoapods"

# Development tools
brew "node@18"
brew "sqlboiler"
brew "go"
brew "flutter"
brew "starship"

# Shell utilities
brew "zsh"
brew "zoxide"
brew "eza"
brew "fzf"
brew "zsh-autosuggestions"
brew "zsh-history-substring-search"

# linter
brew "golangci-lint"

# Optional cli
brew "gh"
brew "tlrc"


# Optional: GUI Applications (uncomment if needed)
cask "visual-studio-code"


EOF
    echo "✅ Brewfile created!"
fi

# Install packages from Brewfile
echo -e "\n🚀 Installing packages from Brewfile..."
brew bundle



if command_exists git; then
  # Git configuration
  echo -e "\n📝 Checking Git configuration..."


  # Function to get current git config value
  get_git_config() {
      git config --global --get "$1"
  }

   # Function to configure git user details
    configure_git_user() {
        local type=$1  # 'name' or 'email'
        local current_value=$(get_git_config "user.$type")

        if [ -z "$current_value" ]; then
            echo "Git user.$type is not set"
            read -p "Enter your $type for Git: " new_value
            git config --global "user.$type" "$new_value"
            echo "✅ Git user.$type set to: $new_value"
        else
            read -p "Current Git $type is '$current_value'. Would you like to change it? (y/N) " should_change
            if [[ $should_change =~ ^[Yy]$ ]]; then
                read -p "Enter new $type for Git: " new_value
                git config --global "user.$type" "$new_value"
                echo "✅ Git user.$type updated to: $new_value"
            else
                echo "✅ Keeping current Git $type: $current_value"
            fi
        fi
    }

    # Configure name and email
    configure_git_user "name"
    configure_git_user "email"




  echo "✅ Git configuration complete!"
else
    echo "❌ Git installation failed. Please install Git manually and run this script again."
fi

# Setup ZSH environment
echo -e "\n🐚 Setting up ZSH environment..."

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p "$HOME/.config/zsh/.zfunctions"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.cache"

# Install antidote if not already installed
if [ ! -d "$HOME/.config/zsh/.antidote" ]; then
    echo "🔌 Installing antidote plugin manager..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.config/zsh/.antidote"
fi

# Stow configuration
echo -e "\n🔗 Setting up symlinks with GNU Stow..."

# Backup existing dotfiles
backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
echo "📦 Creating backup directory: $backup_dir"
mkdir -p "$backup_dir"

# Function to backup existing files
backup_if_exists() {
    local file="$1"
    if [ -e "$file" ]; then
        echo "🔄 Backing up $file"
        mv "$file" "$backup_dir/"
    fi
}

# List of dotfiles/directories to check before stowing
declare -a dotfiles=(
    ".aliases"
    ".gitconfig"
    ".config/kitty"
    ".config/starship.toml"
    ".config/vscode"
    ".zshrc"
    ".zshenv"
    ".zprofile"
)

# Backup existing dotfiles
for file in "${dotfiles[@]}"; do
    backup_if_exists "$HOME/$file"
done

# Create necessary .config directories
mkdir -p "$HOME/.config"

# Stow each configuration package
echo "🔗 Creating symlinks..."
packages=(
    "aliases"
    "git"
    "kitty"
    "starship"
    "vscode"
    "zsh"
)

for package in "${packages[@]}"; do
    echo "📦 Stowing $package"
    stow --restow --target="$HOME" "$package"
done

echo "✅ Dotfiles installation complete!"
echo "🚀 Please restart your terminal or run 'source ~/.zshenv' to apply the changes."
