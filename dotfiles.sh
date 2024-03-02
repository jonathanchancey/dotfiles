#!/bin/sh

export GUM_INPUT_CURSOR_FOREGROUND="#B57EDC"
export GUM_INPUT_PROMPT_FOREGROUND="#0FF"
export GUM_INPUT_PLACEHOLDER="What's up?"
export GUM_INPUT_PROMPT="* "
export GUM_INPUT_WIDTH=80

# check if ui library is installed
command -v gum >/dev/null 2>&1 || {
    echo >&2 "Please install gum using your package manager"; echo "more details https://github.com/charmbracelet/gum?tab=readme-ov-file#installation";
    exit 1;
    }

TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --placeholder "scope")

# Since the scope is optional, wrap it in parentheses if it has a value.
test -n "$SCOPE" && SCOPE="($SCOPE)"

# Pre-populate the input with the type(scope): so that the user may change it
SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

gum confirm "Commit changes?" && echo "$SUMMARY and $DESCRIPTION"
