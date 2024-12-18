return{
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"norg", "text" },
        callback = function()
          vim.keymap.set("i", "<CR>", '<Plug>(neorg.itero.next-iteration)', { buffer = true, noremap = true})
          vim.keymap.set("i", '<M-CR>', "\n", { buffer = true})
        end,
      })
}
