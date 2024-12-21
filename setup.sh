
# Paths
DOTFILES_DIR="$HOME/Documents/GitHub/dotfiles"
BACKUP_DIR="$DOTFILES_DIR/backup"
TARGETS=(
    "$DOTFILES_DIR/zsh/.zshrc:$HOME/.zshrc"
    "$DOTFILES_DIR/tmux/.tmux.conf:$HOME/.tmux.conf"
    "$DOTFILES_DIR/nvim:$HOME/.config/nvim"
)

# Helper Functions
log(){
    local msg=$1
    local lvl=${2:-INFO}
    echo "[$lvl] $msg"
}


create_symlink(){
    # Source and Destination
    local src=$1
    local dst=$2

    # Backup Path Variable
    local backup_file="$BACKUP_DIR/$(basename $dst).backup.$(date +%Y%m%d%H%M%S)"

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        log "Target exists, backing up: $dst to $backup_file" WARN
        mv "$dst" "$backup_file"
    fi

    ln -s "$src" "$dst"
    log "Linked: $src → $dst"
}

echo

log "Starting dotfiles setup..."

log "Creating backup dir: $BACKUP_DIR"
mkdir -p $BACKUP_DIR

for target in "${TARGETS[@]}"; do
    echo 

    IFS=":" read -r src dst <<< "$target"
    
    if [ -d "$src" ]; then
        log "Processing directory: $src"
    
    elif [ -f "$src" ]; then
        log "Processing file: $src"
    
    fi
    create_symlink "$src" "$dst"
done


log "Dotfiles setup complete."
echo
