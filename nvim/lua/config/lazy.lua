-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
 -- Lua LSP
require("lspconfig").lua_ls.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",  -- Neovim uses LuaJIT
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },  -- Recognize the vim global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),  -- Make sure Neovim API is recognized
      },
      telemetry = {
        enable = false,  -- Disable telemetry
      },
      format = {
        enable = true,  -- Enable formatting for lua_ls
        defaultConfig = {
          indentStyle = "space",  -- Use spaces for indentation
          indentSize = 2,  -- Set indentation size to 2 spaces
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Ensure the formatting capability is active
    if client.resolved_capabilities.document_formatting then
      print("Lua LSP Formatter enabled")
    else
      print("Lua LSP Formatter not available")
    end

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show documentation
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true }) -- Format code
    end, opts)
  end,
})   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
