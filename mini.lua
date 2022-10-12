-- Use Vim packages install the plugin, also work with some plugins manager such as packer.nvim
-- vim.o.packpath = '~/.local/share/nvim/site'
vim.o.packpath = '~/.local/share/lunarvim/site'
vim.cmd('packadd promise-async')
vim.cmd('packadd nvim-ufo')

-- Setting
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = -1
vim.o.foldenable = true

local ufo = require('ufo')
ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
