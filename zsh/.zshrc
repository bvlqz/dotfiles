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

setopt prompt_subst
precmd_prompt() {
    local git_info=""  # Placeholder for Git info
    local git_status

    # Check for Git repository
    git_status=$(git status --porcelain=v1 2>/dev/null || true) # Prevent errors in non-Git directories
    if [[ -n $git_status ]]; then
        local repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
        local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
        local changes=$(echo "$git_status" | wc -l)
        git_info="${repo_name} on ${branch_name} (${changes} changes)"
    fi

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
