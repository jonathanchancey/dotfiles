#!/bin/sh

# config
VAULT_SECRET_DIR="$HOME/.config/ansible-vault"
VAULT_SECRET="$VAULT_SECRET_DIR/vault.secret"
REPO_DIR="$HOME/git/dotfiles"
CONFIG_DIR="$REPO_DIR/.config"
LOG_FILE="$REPO_DIR/dotfiles.log"
IS_FIRST_RUN="$CONFIG_DIR/.has_run"
DOTFILE_REPO_URL='https://github.com/jonathanchancey/dotfiles'

# gum defaults
export GUM_INPUT_CURSOR_FOREGROUND="#b57edc"
export GUM_INPUT_PROMPT_FOREGROUND="#b57edc"
# export GUM_INPUT_PLACEHOLDER="What's up?"
export GUM_INPUT_PROMPT="* "
export GUM_INPUT_WIDTH=80

# check if gum is installed
command -v gum >/dev/null 2>&1 || {
    echo >&2 "Please install gum using your package manager"; echo "more details https://github.com/charmbracelet/gum?tab=readme-ov-file#installation";
    exit 1;
    }

color_text() {
    text=$1
    gum style --foreground "#b57edc" "$text"
}

print_env_check() {
    clear

    gum style \
    --border normal \
    --margin "1" \
    --padding "1" \
    --foreground "#b57edc" \
    --border-foreground "" "dotfiles bootstrap"

    echo "operating system: $(grep '^NAME=' /etc/os-release | cut -d\" -f2)"
    echo "user: $USER"
    echo "home: $HOME"

    # print ansible version
    echo "ansible version: $(ansible-playbook --version | head -n1 | sed 's/.*\[\(.*\)\].*/\1/')"

    # check if repo exists
    if [ -d "$REPO_DIR" ]; then
        echo "dotfiles repo: :white_check_mark:" | gum format -t emoji
    else
        # if not, ask to clone it later
        echo "dotfiles repo: :x:" | gum format -t emoji
        export REPO_DIR_MISSING=true
    fi

    # check if vault secret file exists with correct perms
    if [ -s "$VAULT_SECRET" ]; then
        # if exists, continue
        if [ "$(stat -c "%a" "$VAULT_SECRET")" -eq 600 ]; then
            echo "vault secret: :white_check_mark:" | gum format -t emoji
        else
            echo "vault secret: :heavy_check_mark: (does not have 600 permissions)" | gum format -t emoji
            export VAULT_SECRET_WRONG_PERMS=true
        fi
    else
        echo "vault secret: :x: (missing)" | gum format -t emoji
        export VAULT_SECRET_MISSING=true
    fi

    # ready to proceed
    if [ -z "$VAULT_SECRET_MISSING" ] && [ -z "$REPO_DIR_MISSING" ] && [ -z "$VAULT_SECRET_WRONG_PERMS" ]; then
        echo '{{ Bold "ready to go!" }}' | gum format -t template
        YES="run ansible!"
        NO="wait cancel!"

        CHOICE=$(gum choose "$YES" "$NO")

        # if yes, clone
        if [ "$CHOICE" == "$YES" ]; then
            cd $REPO_DIR
            ansible-playbook main.yml
        fi
    fi
}

print_env_check

# ask for vault secret
if [ -n "$VAULT_SECRET_MISSING" ]; then
    mkdir -p $VAULT_SECRET_DIR
    gum input --placeholder "paste your secret here" --password > $VAULT_SECRET
    chmod 600 $VAULT_SECRET
    VAULT_SECRET_MISSING=""
    print_env_check
fi

# fix vault secret perms
if [ -n "$VAULT_SECRET_WRONG_PERMS" ]; then
    chmod 600 $VAULT_SECRET
    VAULT_SECRET_WRONG_PERMS=""
    print_env_check
fi

# clone if repo missing
if [ -n "$REPO_DIR_MISSING" ]; then
    # ask first
    echo "clone repo to $REPO_DIR?"
    YES="Yes, please!"
    NO="No, thank you!"

    CHOICE=$(gum choose "$YES" "$NO")

    # if yes, clone
    if [ "$CHOICE" == "$YES" ]; then
        mkdir -p $REPO_DIR
        gum spin --title "cloning" -- git clone $DOTFILE_REPO_URL $REPO_DIR
        REPO_DIR_MISSING=""
    fi

    print_env_check
fi

