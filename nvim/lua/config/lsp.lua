-- Centralized on_attach function with keymaps
local function on_attach(client, bufnr)
    -- Keymaps for LSP functionality

    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    -- Show documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Format code with description for "Format"
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })                 -- Format code
    end, vim.tbl_extend("force", opts, { desc = "Format" })) -- Add description here
end

-- Setup Mason and LSP
require("mason").setup({
    ensure_installed = { "stylua", "lua_ls", "pyright", "clangd", "gopls" } -- Ensure required tools are installed
})

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "clangd", "gopls" }, -- Ensure servers are installed
})

-- Configure LSP servers
require("mason-lspconfig").setup_handlers({
    function(server_name)
        -- Only define capabilities once
        local opts = {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = on_attach, -- Use the centralized on_attach function
        }

        -- Lua LSP (specific configuration)
        if server_name == "lua_ls" then
            opts.settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT", -- Neovim uses LuaJIT
                        path = vim.split(package.path, ";"),
                    },
                    diagnostics = {
                        globals = { "vim" }, -- Recognize the vim global
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true), -- Make sure Neovim API is recognized
                    },
                    telemetry = {
                        enable = false, -- Disable telemetry
                    },
                    format = {
                        enable = true,             -- Enable formatting for lua_ls
                        defaultConfig = {
                            indentStyle = "space", -- Use spaces for indentation
                            indentSize = 2,        -- Set indentation size to 2 spaces
                        },
                    },
                },
            }
        end

        require("lspconfig")[server_name].setup(opts)
    end,
})

-- Python LSP (pyright)
require("lspconfig").pyright.setup({
    -- No need to redefine capabilities here since it's handled centrally
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic", -- Enable basic type checking
            },
        },
    },
})

-- C++ LSP (clangd)
require("lspconfig").clangd.setup({
    -- No need to redefine capabilities here since it's handled centrally
    cmd = { "clangd", "--background-index", "--clang-tidy" }, -- Enable Clang-Tidy
})

-- Go LSP (gopls)
require("lspconfig").gopls.setup({
    -- No need to redefine capabilities here since it's handled centrally
    settings = {
        gopls = {
            analyses = {
                unusedparams = true, -- Enable analysis for unused parameters
            },
            staticcheck = true,      -- Enable static analysis checks
        },
    },
})
