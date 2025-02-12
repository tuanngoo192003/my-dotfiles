return {
    -- Mason plugin to manage external LSP servers and tools
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",  -- Optional: To make the Mason UI more visually appealing
                },
            })
        end,
    },

    -- Mason-LSPconfig plugin to easily configure LSPs with Mason
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "jdtls" },  -- Ensure Lua and JDTLS (Java) are installed
            })
        end,
    },

    -- Neovim LSP configuration
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local mason_registry = require("mason-registry")
            local cmp_nvim_lsp = require('cmp_nvim_lsp')

            -- Setup capabilities for completion
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Setup Java LSP (jdtls) with the correct path for Windows
            local jdtls_path = mason_registry.get_package("jdtls"):get_install_path() .. "\\bin\\jdtls.bat"  -- Windows batch file path

            lspconfig.jdtls.setup({
                cmd = { jdtls_path, "-data", "C:\\Users\\84393\\workspace\\java" },  -- Replace with your workspace path
                root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle"),  -- LSP root determination
                capabilities = capabilities,  -- Add capabilities for LSP features like completion
                on_attach = function(client, bufnr)
                    -- Key mappings for code actions
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ci', '<Cmd>lua vim.lsp.buf.code_action({ context = { only = {"quickfix"} } })<CR>', { noremap = true, silent = true })
                    print("JDTLS server attached to buffer " .. bufnr)
                end,
            })
        end,
    },

    -- nvim-jdtls plugin to ensure proper setup for Java LSP
    {
        "mfussenegger/nvim-jdtls",
        config = function()
            -- Optional: You can configure nvim-jdtls more here if needed, like adding additional setups
        end,
    },

    -- nvim-cmp for autocompletion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require('cmp')

            -- Configure nvim-cmp
            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- Ensure you have a snippet engine installed, e.g. luasnip or others
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                },
                sources = {
                    { name = 'nvim_lsp' },  -- LSP completion
                    { name = 'buffer' },    -- Buffer completion
                    { name = 'path' },      -- Path completion
                    { name = 'luasnip' },   -- Snippet completion
                },
                experimental = {
                    native_menu = false,  -- Optional: Disable native menu for better control
                    ghost_text = true,    -- Optional: Show ghost text for completion suggestions
                },
            })
        end,
    },

    -- Add additional completion sources if needed
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "hrsh7th/cmp-buffer",
    },
    {
        "hrsh7th/cmp-path",
    },

    -- Snippet support
    {
        "L3MON4D3/LuaSnip",
        config = function()
            local luasnip = require('luasnip')

            -- Optional: Add your snippets here if you have custom ones
            -- luasnip.snippets = {
            --   lua = {
            --     luasnip.parser.parse_snippet("trigger", "snippet body"),
            --   },
            -- }
        end,
    },
}
