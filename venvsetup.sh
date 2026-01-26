#!/bin/bash

existing_venv=$(find . -maxdepth 2 -name "pyvenv.cfg")
existing_req=$(find . -name "requirements.txt")

# IF EXISTING VENV HAVE SOMETHING, USE THIS PATH FOR WORK
venv_path=${existing_venv::-11}

create_venv() {
    if [ -z "$existing_venv" ]; then
        echo "No venv found, creating one..."
        read -p "Type the name of your venv: " name
        echo "Creating $name virtual environement..."
        python3 -m venv $name
        echo ""
    fi
}

start_venv(){
    if [ -z "$VIRTUAL_ENV" ]; then
    echo "Enabling the venv..."
    source $venv_path/bin/activate
    echo ""
fi
}

gitignore() {
    echo "Do you want the to add the venv in a .gitignore? (recomended)"
    read -p " y / n " choice
    if [ "$choice" = "y" ]; then 
        echo "Adding the venv in a gitignore..."
        echo "$venv_path >> .gitignore"
        echo "Done!"
    elif [ "$choice" = "n" ];then
        echo "Got it!"
    else 
        echo "No choices detected!"
    fi
}

requirements(){
    if [ -n "$existing_req" ]; then
    echo "Packages required detected (requirements.txt), do you want to install them? "
        read -p " y / n " choice
        if [ "$choice" = "y" ]; then 
            pip install -r requirements.txt
            echo "Done!"
        elif [ "$choice" = "n" ];then
            echo "Got it!"
        else 
            echo "No choices detected!"
        fi
    fi
}

echo "Python venv tool"
echo "Make sure you are inside your workspace, this script will work if it finds the right folder"
echo ""

create_venv

start_venv

gitignore

pip install --upgrade pip

requirements

echo "Your venv is setup and launched!"



