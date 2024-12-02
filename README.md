# JocTe's Dotfiles 🚀

This repository contains my personal dotfiles, managed with GNU Stow and configured for a modern development environment.

## Prerequisites

- macOS or Linux
- Git

## What's Included 📦

### Shell Configuration

- **ZSH** as the default shell
- **Antidote** for plugin management
- **Starship** for a minimal, powerful prompt
- Custom ZSH configuration with:
  - Fish-like features (syntax highlighting, autosuggestions)
  - Better history management
  - Smart completions
  - Directory jumping with `z`
  - And more!

### Terminal

- **Kitty** - A fast, GPU-based terminal emulator
  - Custom theme configuration
  - Keyboard shortcuts

### Development Tools

- **Git** configuration
  - Global gitignore
  - Useful aliases
  - Default configurations
- **VSCode** settings
  - Keybindings
  - User settings

### Package Management

- **Homebrew** for package management
- Essential packages:
  - `git`: Version control
  - `curl`, `wget`: HTTP requests
  - `vim`: Text editor
  - `node`: JavaScript runtime
  - `go`: Go programming language
  - `flutter`: UI toolkit

## Installation 💻

1. Clone the repository to your home directory:

```bash
git clone https://github.com/YourUsername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Run the installation script:

```bash
./install.sh
```

The script will:

- Install Homebrew if not present
- Install all required packages through Brewfile
- Set up Git configuration
- Install Antidote (ZSH plugin manager)
- Create all necessary symlinks using GNU Stow
- Backup any existing configurations

## ZSH Plugins 🔌

The following plugins are installed and configured:

- `rupa/z`: Quick directory jumping
- `zsh-users/zsh-autosuggestions`: Fish-like autosuggestions
- `zdharma-continuum/fast-syntax-highlighting`: Syntax highlighting
- `zsh-users/zsh-history-substring-search`: Better history search
- `ohmyzsh/ohmyzsh`: Selected components from Oh My Zsh
- `zsh-users/zsh-completions`: Additional completions
- And more!

## Directory Structure 📁

```
.dotfiles/
├── aliases/
│   └── .config/
│       └── .aliases
├── git/
│   └── .gitconfig
├── kitty/
│   └── .config/kitty/
│       ├── kitty.conf
│       └── theme.conf
├── starship/
│   └── .config/
│       └── starship.toml
├── vscode/
│   └── .config/vscode/
│       ├── keybindings.json
│       └── settings.json
├── zsh/
│   ├── .config/zsh/
│   │   ├── .antidote/
│   │   ├── .zfunctions/
│   │   ├── .zshrc
│   │   └── .zsh_plugins.txt
│   └── .zshenv
├── install.sh
└── README.md
```

## Configuration Details ⚙️

### Environment Variables

- `XDG_CONFIG_HOME`: `~/.config`
- `XDG_DATA_HOME`: `~/.local/share`
- `XDG_CACHE_HOME`: `~/.cache`
- `ZDOTDIR`: `~/.config/zsh`
- `EDITOR` and `VISUAL`: Set to VSCode
- Custom paths for development workspace and dotfiles

### History Configuration

- Saves up to 10,000 commands
- Eliminates duplicates
- Stored in `~/.config/zsh/.zhistory`

## Customization 🎨

To modify the configuration:

1. Edit the relevant files in their respective directories
2. Re-run `stow` for the modified package:

```bash
stow --restow <package_name>
```

Or re-run the installation script to update everything:

```bash
./install.sh
```

## Backup ⚠️

The installation script automatically creates backups of existing configurations in:

```
~/.dotfiles_backup/YYYYMMDD_HHMMSS/
```

## Troubleshooting 🔧

If you encounter any issues:

1. Check the backup directory for your original configurations
2. Ensure all required packages are installed: `brew bundle check`
3. Try restowing individual packages: `stow --restow <package_name>`
4. Check ZSH plugin status: `antidote list`

## Contributing 🤝

Feel free to submit issues and pull requests for improvements!

## License 📝

This project is licensed under the MIT License - see the LICENSE file for details.
