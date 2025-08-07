#!/bin/bash

# taken from https://bea.stollnitz.com/blog/codespaces-terminal/
create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

create_symlinks

install_fzf() {
    if ! command -v fzf &> /dev/null; then
        echo "Installing fzf..."
        if [[ "$(uname)" == "Darwin" ]]; then
            # On macOS, install with Homebrew
            if command -v brew &> /dev/null; then
                brew install fzf
                # To install useful key bindings and fuzzy completion:
                "$(brew --prefix)/opt/fzf/install" --all
            else
                echo "Warning: Homebrew is not installed. Cannot install fzf."
                echo "Please install Homebrew or install fzf manually."
            fi
        else
            # On Linux
            if command -v apt-get &> /dev/null; then
                # Debian/Ubuntu
                sudo apt-get update
                sudo apt-get install -y fzf
            elif command -v apk &> /dev/null; then
                # Alpine Linux
                sudo apk add fzf
            else
                # Fallback to git clone for other Linux distributions
                echo "Could not find apt-get or apk. Installing fzf from source."
                git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
                ~/.fzf/install --all
            fi
        fi
    else
        echo "fzf is already installed."
    fi
}

install_fzf


source <(fzf --zsh)
