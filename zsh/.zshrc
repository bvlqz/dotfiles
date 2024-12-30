
# Aliases
alias ll='ls -lah'
alias vim='nvim'

# Oh My Zsh setup
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Enable plugins
plugins=(git)

trim() {
    local var="$1"
    echo "$var" | xargs
}

# Function to draw a continuous line
fill_line() {
    local columns=$COLUMNS
    echo "%F{0}$(printf '%*s' "$columns" '' | tr ' ' '-')%f"
}


# Git status function
get_git_status() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local repo_name=$(basename "$(git rev-parse --show-toplevel)")
        local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
        local staged=$(git diff --cached --numstat | wc -l | xargs)
        local unstaged=$(git diff --numstat | wc -l | xargs)
        local untracked=$(git ls-files --others --exclude-standard | wc -l | xargs)
        local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
        local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0)

        local changes=""
        (( staged > 0 )) && changes+="${staged} staged, "
        (( unstaged > 0 )) && changes+="${unstaged} unstaged, "
        (( untracked > 0 )) && changes+="${untracked} untracked"
        changes=${changes%, } # Remove trailing comma

        local dirty_status=""
        (( staged + unstaged > 0 )) && dirty_status="%F{005}uncommitted%f"

        if [[ -z "$changes" && -z "$dirty_status" ]]; then
            changes="working tree clean"
        fi

        echo "%F{013}${repo_name}%f on branch %F{211}${branch_name}%f: ↑%F{010}${ahead}%f ↓%F{009}${behind}%f (${changes}${dirty_status:+, ${dirty_status}})"
    fi
}

# Prompt function
precmd_prompt() {
    local git_info=$(get_git_status)
    local clock_right="%F{011}$(date +'%H:%M:%S')%f"
    local prompt_left="%F{010}${USER}@mini%f:%F{012}$(pwd)%f"

    local left_length=${#prompt_left}
    local clock_length=${#clock_right}
    local total_length=$((left_length + clock_length))
    local padding_length=$((COLUMNS - total_length + 27))

    PROMPT=$'\n'
    PROMPT+="$(fill_line)"
    PROMPT+=$'\n'
    PROMPT+="${prompt_left}$(printf '%*s' "$padding_length" '')${clock_right}"
    PROMPT+=$'\n'
    [[ -n $git_info ]] && PROMPT+="${git_info}" && PROMPT+=$'\n'
    PROMPT+="%F{015}$%f "
}

# Set options and register the prompt
setopt prompt_subst
precmd_functions+=(precmd_prompt)


