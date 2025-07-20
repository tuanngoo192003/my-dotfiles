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
                ensure_installed = { "lua_ls", "jdtls", "gopls" },
            })
        end,
    },

    -- Neovim LSP configuration
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local mason_registry = require("mason-registry")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- Setup capabilities for completion
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Setup Java LSP (jdtls) with the correct path for Windows
            local jdtls_path = mason_registry.get_package("jdtls"):get_install_path() .. "\\bin\\jdtls.bat"

            lspconfig.jdtls.setup({
                cmd = { jdtls_path, "-data", "C:\\Users\\84393\\workspace\\java" },
                root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle"),
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ci", "<Cmd>lua vim.lsp.buf.code_action({ context = { only = {\"quickfix\"} } })<CR>", { noremap = true, silent = true })
                    print("JDTLS server attached to buffer " .. bufnr)
                end,
            })

            -- Setup Go LSP (gopls)
            lspconfig.gopls.setup({
                capabilities = capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = function(fname)
                    return lspconfig.util.root_pattern("go.work", "go.mod", ".git")(fname) or vim.fn.getcwd()
                end,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
                on_attach = function(client, bufnr)
                        -- Open floating diagnostic window
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

                        -- You can also add go-to-definition, hover, etc. here
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

                        -- Add code actions too if you want (like in your jdtls)
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
                    end,
             })
        end,
    },

    -- nvim-jdtls plugin for Java LSP
    {
        "mfussenegger/nvim-jdtls",
    },

    -- nvim-cmp for autocompletion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "luasnip" },
                },
                experimental = {
                    ghost_text = true,
                },
            })
        end,
    },

    -- Additional completion sources
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },

    -- Snippet support
    {
        "L3MON4D3/LuaSnip",
    },
}
