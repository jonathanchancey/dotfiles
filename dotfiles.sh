#!/bin/sh

# config
VAULT_SECRET_DIR="$HOME/.config/ansible-vault"
VAULT_SECRET="$VAULT_SECRET_DIR/vault.secret"
REPO_DIR="$HOME/git/dotfiles"
CONFIG_DIR="$REPO_DIR/.config"
LOG_FILE="$REPO_DIR/dotfiles.log"
IS_FIRST_RUN="$CONFIG_DIR/.has_run"

# gum defaults
export GUM_INPUT_CURSOR_FOREGROUND="#B57EDC"
export GUM_INPUT_PROMPT_FOREGROUND="#0FF"
export GUM_INPUT_PLACEHOLDER="What's up?"
export GUM_INPUT_PROMPT="* "
export GUM_INPUT_WIDTH=80

# check if gum is installed
command -v gum >/dev/null 2>&1 || {
    echo >&2 "Please install gum using your package manager"; echo "more details https://github.com/charmbracelet/gum?tab=readme-ov-file#installation";
    exit 1;
    }

gum style \
  --border normal \
  --margin "1" \
  --padding "1" \
  --border-foreground "" "dotfiles bootstrap"

# os family
echo "operating system: $(grep '^NAME=' /etc/os-release | cut -d\" -f2)"

# print user
echo "user: $USER"

# print home
echo "home: $HOME"

# print ansible version
echo "$(gum style --foreground 212 'ansible version:') $(ansible-playbook --version | head -n1 | sed 's/.*\[\(.*\)\].*/\1/')"

# check if repo exists
if [ -d "$REPO_DIR" ]; then
    echo "repo dir: exists"
else
    # flag to ask to clone it later
    echo "repo dir: missing"
    export VAULT_SECRET_WRONG_PERMS=true
fi

# check if vault secret file exists with correct perms
if [ -s "$VAULT_SECRET" ]; then
    # if exists, continue
    if [ "$(stat -c "%a" "$VAULT_SECRET")" -eq 600 ]; then
        echo "vault secret: exists with correct permissions"
    else
        echo "vault secret: exists but does not have 600 permissions"
        export VAULT_SECRET_WRONG_PERMS=true
    fi
else
    echo "vault secret: missing"
    export VAULT_SECRET_MISSING=true
fi

# ask for vault secret
if [ -n "$VAULT_SECRET_MISSING" ]; then
    mkdir -p $VAULT_SECRET_DIR
    gum input --password > $VAULT_SECRET
    chmod 600 $VAULT_SECRET
fi

# fix vault secret perms
if [ -n "$VAULT_SECRET_WRONG_PERMS" ]; then
    chmod 600 $VAULT_SECRET
fi


# TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
# SCOPE=$(gum input --placeholder "scope")

# # Since the scope is optional, wrap it in parentheses if it has a value.
# test -n "$SCOPE" && SCOPE="($SCOPE)"

# # Pre-populate the input with the type(scope): so that the user may change it
# SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
# DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

# gum confirm "Commit changes?" && echo "$SUMMARY and $DESCRIPTION"
