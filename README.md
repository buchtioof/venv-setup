# venv-setup
simple script to avoid redundant python venv setup

## why
the project is to continue to learn deeper bash scripting and try to make a script usable for everyone via package managers like homebrew, etc...

## what it does
> this script does basics to start a virtual environment inside your workspace
- [x] create your venv and asks the name
- [x] adds the venv in gitignore to avoid useless commits
- [x] starts the venv to install packages by asking the user which ones

## how to use
to run the script, use this command:

`bash <(curl -fsSL https://raw.githubusercontent.com/buchtioof/venv-setup/main/venvsetup.sh)`
> be sure to use it INSIDE your workspace

*(tested and works fine on Debian, soon testing on macos)*
