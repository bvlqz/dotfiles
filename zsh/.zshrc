# Aliases
alias ll='ls -lah'
alias vim='nvim'

# Oh My Zsh setup
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Enable plugins
plugins=(git)

# Function to draw a continuous line
fill_line() {
    local columns=$COLUMNS
    printf '%*s\n' "$columns" '' | tr ' ' '-'
}

# Git status function using Oh My Zsh Git plugin
get_git_status() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
        local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)

        # Changes
        local staged=$(git diff --cached --name-only | wc -l | tr -d ' ')
        local unstaged=$(git diff --name-only | wc -l | tr -d ' ')
        local untracked=$(git ls-files --others --exclude-standard | wc -l | tr -d ' ')
        local changes=$((staged + unstaged))
        local changes_text="${staged} staged, ${unstaged} unstaged"
        [[ $untracked -gt 0 ]] && changes_text="${changes_text}, ${untracked} untracked"
        [[ $changes -eq 1 ]] && changes_text="${changes_text} change" || changes_text="${changes_text} changes"

        # Ahead/Behind
        local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
        local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "0")

        # Upstream Branch
        local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "")
        [[ -n $upstream ]] && branch_name="${branch_name} (${upstream})"

        # Dirty State
        local is_dirty=""
        if [[ $changes -gt 0 ]]; then
            is_dirty=", uncommitted"
        fi

        # Final Output
        echo "${repo_name} on branch ${branch_name}: ↑${ahead} ↓${behind} (${changes_text}${is_dirty})"
    fi
}


setopt prompt_subst
precmd_prompt() {
    local git_info
    git_info=$(get_git_status)

    # Prepare clock on the right
    local clock_right="$(date +'%H:%M:%S')"
    local clock_length=${#clock_right}

    # Prepare left prompt text
    local prompt_left="${USER} at Mac Mini"
    local left_length=${#prompt_left}

    # Calculate spacing for center alignment
    local total_length=$((left_length + clock_length)) # 2 for the gap
    local padding_length=$((COLUMNS - total_length))

    # Add spaces between left and right
    local prompt_columns=$(printf '%*s' "$padding_length" '')

    # Combine the full prompt
    local prompt_full="${prompt_left}${prompt_columns}${clock_right}"

    # Build PROMPT
    PROMPT=$'\n'
    PROMPT+="$(fill_line)"
    PROMPT+=$'\n'
    PROMPT+="${prompt_full}"
    PROMPT+=$'\n'
    if [[ -n $git_info ]]; then
        PROMPT+="${git_info}"
        PROMPT+=$'\n'
    fi
    PROMPT+="$ "
}

# Register the prompt function
precmd_functions+=(precmd_prompt)
