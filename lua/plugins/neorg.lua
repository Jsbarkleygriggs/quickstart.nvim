return ({
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    },

    {
        "Jsbarkleygriggs/neorg-nabla.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-neorg/neorg" },   -- vim.cmd([[TSInstall latex]])
        config = function()
            -- Set up autocmd for Neorg files
            vim.api.nvim_create_autocmd("FileType", {
                -- pattern = "norg, tex",
                pattern = { "norg", "tex", "txt", "text" },
                callback = function()
                    -- Enable nabla for Neorg files
                    vim.cmd([[setlocal conceallevel=2]])
                    vim.cmd([[setlocal concealcursor=nc]])
                    require('nabla').enable_virt({
                        autogen = true,
                    })
                end
            })
        end,
    },

    {
        "dhruvasagar/vim-table-mode",
        config = function()
            -- We'll set up an autocommand to enable TableMode only for Neorg files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"norg", "text" },
                callback = function()
                    vim.cmd([[TableModeEnable]])
                end,
            })
        end,
        },

    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        -- put any other flags you wanted to pass to lazy here!
        config = function()

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"norg", "text" },
                callback = function()
                    vim.keymap.set("i", "<CR>", '<Plug>(neorg.itero.next-iteration)', { buffer = true, noremap = true})
                    vim.keymap.set("i", '<M-CR>', "\n", { buffer = true})
                end,
            })

            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.itero"] = {
                        config = {
                            iterables = {
                                "unordered_list%d",
                                "ordered_list%d",
                                "quote%d",
                                -- "heading%d" is removed from this list
                            },
                        },
                    },
                    ["core.concealer"] = {
                        config = {
                            folds = true,
                            icon_preset = "diamond",
                        },
                    },
               },
            })
        end,
    },
})

