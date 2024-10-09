--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Improved kj navigation; goes by wrapped lines unless you tell it the relitive line number
vim.keymap.set({'n', 'v'}, 'j', 'v:count == 0 ? "gj" : "j"', { noremap = true, expr = true })
vim.keymap.set({'n', 'v'}, 'k', 'v:count == 0 ? "gk" : "k"', { noremap = true, expr = true })

-- Navigation bindings
vim.keymap.set('n', '<leader>n', ':Neotree<CR>', { desc = 'open file explorer' })

-- Splits
vim.keymap.set('n', '<leader>-', ':5split | term<CR>', { desc = 'open terminal below' })
vim.keymap.set('n', '<leader>\\', ':vsplit | term<CR>', { desc = 'open terminal right' })
vim.keymap.set('n', '<leader>|', ':vsplit<CR>', { desc = 'duplicate below' })
vim.keymap.set('n', '<leader>_', ':split<CR>', { desc = 'duplicate right' })

-- Envoke LLM
vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>')

-- Colapse and open functions
  -- See fold.lua

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Ensure that Telescope is loaded
local telescope_ok, builtin = pcall(require, 'telescope.builtin')
if not telescope_ok then
  vim.notify("Error loading Telescope: " .. tostring(builtin), vim.log.levels.ERROR)
  return
end

-- Key mappings for Telescope
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Override default behavior and theme for current buffer fuzzy find
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Additional options for live_grep
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Search Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })



local dap = require 'dap'
local keymap_opts = { noremap = true, silent = true }

-- Basic debugging keymaps
vim.keymap.set('n', '<F5>', dap.continue, vim.tbl_extend('force', keymap_opts, { desc = 'Debug: Start/Continue' }))
vim.keymap.set('n', '<M-i>', dap.step_into, vim.tbl_extend('force', keymap_opts, { desc = 'Debug: Step Into' }))
vim.keymap.set('n', '<M-p>', dap.step_over, vim.tbl_extend('force', keymap_opts, { desc = 'Debug: Step Over' }))
vim.keymap.set('n', '<M-o>', dap.step_out, vim.tbl_extend('force', keymap_opts, { desc = 'Debug: Step Out' }))
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, vim.tbl_extend('force', keymap_opts, { desc = 'Debug: Toggle Breakpoint' }))
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, vim.tbl_extend('force', keymap_opts, { desc = 'Debug: Set Breakpoint' }))

-- Toggle DAP UI
vim.keymap.set('n', '<F7>', require('dapui').toggle, vim.tbl_extend('force', keymap_opts, { desc = 'Debug: See last session result.' }))


local gitsigns = require 'gitsigns'
local keymap_opts = { noremap = true, silent = true }

-- Navigation
vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    gitsigns.nav_hunk 'next'
  end
end, vim.tbl_extend('force', keymap_opts, { desc = 'Jump to next git [c]hange' }))

vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    gitsigns.nav_hunk 'prev'
  end
end, vim.tbl_extend('force', keymap_opts, { desc = 'Jump to previous git [c]hange' }))

-- Actions
-- Visual mode
vim.keymap.set('v', '<leader>hs', function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, vim.tbl_extend('force', keymap_opts, { desc = 'Stage git hunk' }))

vim.keymap.set('v', '<leader>hr', function()
  gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, vim.tbl_extend('force', keymap_opts, { desc = 'Reset git hunk' }))

-- Normal mode
vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, vim.tbl_extend('force', keymap_opts, { desc = 'Git [s]tage hunk' }))
vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, vim.tbl_extend('force', keymap_opts, { desc = 'Git [r]eset hunk' }))
vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, vim.tbl_extend('force', keymap_opts, { desc = 'Git [S]tage buffer' }))
vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, vim.tbl_extend('force', keymap_opts, { desc = 'Git [u]ndo stage hunk' }))
vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, vim.tbl_extend('force', keymap_opts, { desc = 'Git [R]eset buffer' }))
vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, vim.tbl_extend('force', keymap_opts, { desc = 'Git [p]review hunk' }))
vim.keymap.set('n', '<leader>hb', gitsigns.blame_line, vim.tbl_extend('force', keymap_opts, { desc = 'Git [b]lame line' }))
vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, vim.tbl_extend('force', keymap_opts, { desc = 'Git [d]iff against index' }))
vim.keymap.set('n', '<leader>hD', function()
  gitsigns.diffthis '@'
end, vim.tbl_extend('force', keymap_opts, { desc = 'Git [D]iff against last commit' }))

-- Toggles
vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, vim.tbl_extend('force', keymap_opts, { desc = '[T]oggle git show [b]lame line' }))
vim.keymap.set('n', '<leader>tD', gitsigns.toggle_deleted, vim.tbl_extend('force', keymap_opts, { desc = '[T]oggle git show [D]eleted' }))



local telescope = require('telescope.builtin')
local lsp = vim.lsp

-- LSP Mappings
local function lsp_keymaps(bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
  map('gr', telescope.lsp_references, '[G]oto [R]eferences')
  map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
  map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
  map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
  map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  map('<leader>rn', lsp.buf.rename, '[R]e[n]ame')
  map('<leader>ca', lsp.buf.code_action, '[C]ode [A]ction')
  map('K', lsp.buf.hover, 'Hover Documentation')
  map('gD', lsp.buf.declaration, '[G]oto [D]eclaration')
end

-- Set up autocommand for LSP Attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    lsp_keymaps(event.buf)

    local client = lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = lsp.buf.clear_references,
      })
    end
  end,
})
