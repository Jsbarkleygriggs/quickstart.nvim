return{
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    config = function()

      require('config.binds.notes')

      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          --["core.neorgcmd"] = {},
          --["core.integrations.image"] = {},
          --["core.latex.renderer"] = {},
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
          ["core.export"] = {},
          ["core.ui"] = {},
          ["core.ui.calendar"] = {},
          ["core.qol.toc"] = {},
          ["core.concealer"] = {
            config = {
              folds = true,
              icon_preset = "diamond",
              vim.cmd([[setlocal conceallevel=2]]),
              --vim.cmd([[setlocal concealcursor=nc]]),
            },
          },
        },
      })
    end,
  },

  {
  },
}
-- fix bindings
-- refactor autocmd with ai
-- get todo from notes
-- auto toc
--
--
--

--    {
--        "3rd/image.nvim",
--       dependencies = { "luarocks.nvim" },
--        config = function()
--            -- ...
--        end
--    },

--    {
--        "Jsbarkleygriggs/neorg-nabla.nvim",
--        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-neorg/neorg" },   -- vim.cmd([[TSInstall latex]])
--        config = function()
            -- Set up autocmd for Neorg files
--            vim.api.nvim_create_autocmd("FileType", {
                -- pattern = "norg, tex",
--                pattern = { "norg", "tex", "txt", "text" },
--                callback = function()
                    -- Enable nabla for Neorg files
--                    require('nabla').enable_virt({
--                        autogen = true,
--                    })
--                end
--            })
--        end,
--    },


--    {
--        "jbyuki/quickmath.nvim",
--        config = function()
--            -- We'll set up an autocommand to enable TableMode only for Neorg files
--            vim.api.nvim_create_autocmd("FileType", {
--                pattern = {"norg", "text" },
--                callback = function()
--                    vim.cmd([[Quickmath]])
--                end,
--            })
--        end,
--    },


--    {
--        "dhruvasagar/vim-table-mode",
--        config = function()
--            -- We'll set up an autocommand to enable TableMode only for Neorg files
--            vim.api.nvim_create_autocmd("FileType", {
--                pattern = {"norg", "text" },
--                callback = function()
--                    vim.cmd([[TableModeEnable]])
--                end,
--            })
--        end,
--        },

