@echo off

:: Define paths
set DOTFILES_DIR=%USERPROFILE%\Documents\GitHub\dotfiles\nvim
set NVIM_CONFIG_DIR=%USERPROFILE%\AppData\Local\nvim

:: Remove existing Neovim config
if exist "%NVIM_CONFIG_DIR%" (
    echo [INFO] Removing existing Neovim config: "%NVIM_CONFIG_DIR%"
    rmdir /s /q "%NVIM_CONFIG_DIR%"
) else (
    echo [INFO] No existing Neovim config found.
)

:: Create the symlink
echo [INFO] Creating symlink: "%NVIM_CONFIG_DIR%" -> "%DOTFILES_DIR%"
mklink /D "%NVIM_CONFIG_DIR%" "%DOTFILES_DIR%" || (
    echo [ERROR] Failed to create symbolic link. Run as Administrator or enable Developer Mode.
    pause
    exit /b 1
)

echo [INFO] Neovim setup complete.
pause
