#!/bin/bash

set -e

echo "Python venv tool"
echo "Make sure you are inside your workspace"
echo ""

# --- Detect existing venv (first match only)
existing_venv=$(find . -maxdepth 2 -name pyvenv.cfg 2>/dev/null | head -n 1)
existing_req=$(find . -name requirements.txt 2>/dev/null | head -n 1)

if [ -n "$existing_venv" ]; then
    venv_path="${existing_venv%/pyvenv.cfg}"
else
    venv_path=""
fi

# --- Create venv if none found
create_venv() {
    if [ -z "$venv_path" ]; then
        echo "No virtual environment found."
        read -p "Type the name of your venv: " name
        echo "Creating virtual environment: $name"
        python3 -m venv "$name"
        venv_path="./$name"
        echo ""
    fi
}

# --- Add venv to .gitignore
gitignore() {
    if [ -f .gitignore ]; then
        if grep -qx "$venv_path" .gitignore; then
            return
        fi
    fi

    echo "Do you want to add the venv to .gitignore? (recommended)"
    read -p " y / n " choice
    if [ "$choice" = "y" ]; then
        echo "$venv_path" >> .gitignore
        echo "Added $venv_path to .gitignore"
    fi
}

# --- Activate venv
activate_venv() {
    if [ -f "$venv_path/bin/activate" ]; then
        echo "Enabling the venv..."
        # shellcheck disable=SC1090
        source "$venv_path/bin/activate"
        echo ""
    else
        echo "ERROR: activate script not found in $venv_path"
        exit 1
    fi
}

# --- Install requirements
requirements() {
    if [ -n "$existing_req" ]; then
        echo "requirements.txt detected. Install dependencies?"
        read -p " y / n " choice
        if [ "$choice" = "y" ]; then
            pip install -r "$existing_req"
            echo "Dependencies installed"
        fi
    fi
}

# --- Install packages interactively
installer() {
    read -p "Type the package you need to install: " package
    pip install "$package"
}

alfred() {
    read -p "Do you want to install a package? (y / n) " choice
    if [ "$choice" != "y" ]; then
        return
    fi

    installer

    while true; do
        read -p "Do you want to install another package? (y / n) " choice
        if [ "$choice" = "y" ]; then
            installer
        else
            break
        fi
    done
}


# ------------------ MAIN ------------------

create_venv
gitignore
activate_venv
requirements
alfred

echo ""
echo "Your venv is ready!"
echo "To activate it later, run:"
echo "source \"$venv_path/bin/activate\""

