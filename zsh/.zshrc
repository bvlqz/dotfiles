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

    # Format clock aligned to the right
    local clock_right=$(printf '%*s' "$COLUMNS" "[$(date +'%H:%M:%S')]")

    # Build prompt
    
    PROMPT="$(fill_line)"
    PROMPT+="${USER}@ Mac Mini ${clock_right}"
    if [[ -n $git_info ]]; then
        PROMPT+="${git_info}"
        PROMPT+=$'\n'
    fi
    PROMPT+="${USER}@${HOSTNAME} ${clock_right}"
    PROMPT+=$'\n$ '
}

# Register the prompt function
precmd_functions+=(precmd_prompt)
