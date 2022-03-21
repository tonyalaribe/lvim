--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
--lvim.colorscheme = "onedarkpro"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["gt"] = ":pop<cr>"
lvim.keys.normal_mode["K"] = ":lua require'lspsaga.hover'.render_hover_doc()<CR>"


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }


-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

require("nvim-treesitter.install").compilers = { "gcc-11" }
lvim.builtin.treesitter.compilers = { "gcc-11" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"rust",
	"java",
	"yaml",
	"haskell",
}

--lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

local saga = require("lspsaga")
saga.init_lsp_saga()

vim.cmd([[
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true

  " nnoremap <Space> i<Space><Esc>

  " To make your Ctrl+x,Ctrl+o work
  autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

  let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
  let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
  let g:ormolu_ghc_opt=["TypeApplications", "RankNTypes"]
  let g:neoformat_enabled_haskell = ['ormolu']


  " delete should not cut data. <leader>d can be used the way d was used previously
  nnoremap x "_x
  nnoremap d "_d

  " nnoremap D "_D
  vnoremap d "_d

  " Vmap for maintain Visual Mode after shifting > and <
  vmap < <gv
  vmap > >gv

  " vim.cmd('let g:nvim_tree_git_hl = 1')
  nmap <silent> <F3> :NvimTreeToggle<CR>

  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " zoom a vim pane, <C-w>= to re-balance
  nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
  nnoremap <leader>= :wincmd =<cr>

]])

-- Additional Plugins
lvim.plugins = {
	{"folke/tokyonight.nvim" },
	{"folke/trouble.nvim",cmd = "TroubleToggle"},
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
	},
  {'sbdchd/neoformat'},
	{"sindrets/diffview.nvim",event = "BufRead"},
	{"folke/lsp-colors.nvim",event = "BufRead"},
	{"ray-x/lsp_signature.nvim",event = "BufRead",config = function() require("lsp_signature").setup() end},
  {"tami5/lspsaga.nvim"},
	{"simrat39/symbols-outline.nvim",cmd = "SymbolsOutline"},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
		end,
	},
	{ "ndmitchell/ghcid", rtp = "plugins/nvim" },
	{ "michaelb/sniprun", run = "bash ./install.sh" },
	{ "ckipp01/stylua-nvim" },
  { "github/copilot.vim" },
  { "neovimhaskell/haskell-vim" },
  { "nathom/filetype.nvim" },
  { "beauwilliams/focus.nvim", config = function() require("focus").setup() end },
  { "christoomey/vim-tmux-navigator"},
  {"romgrk/nvim-treesitter-context"},
}

lvim.builtin.which_key.mappings["t"] = {
	name = "Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnosticss" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
}

lvim.builtin.which_key.mappings["i"] = {
	name = "Saga",
	r = { "<cmd>lua require'lspsaga.rename'.rename()<CR>", "Rename" },
  i = { "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>", "Hover Doc"},
  f = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", "Find Via LSP" },
  a = { "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", "Code action"},
  k = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", "Preview Definition"},
  d = { "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", "line diagnostic"},
}

lvim.builtin.which_key.mappings["sB"] = {
  "<cmd>lua require'telescope.builtin'.buffers{}<CR>", "Buffers"
}

vim.cmd([[
  " jump diagnostic
  nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
  nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
]])


lvim.builtin.which_key.mappings["z"] = {
	z = { '<cmd>lua require("stylua-nvim").format_file()<CR>', "Format Lua" },
}

require('lspconfig').tailwindcss.setup({
  filetypes = {"haskell", "html", "javascript"},
  settings = {
    tailwindCSS = {
      includeLanguages = {
        haskell = "html"
      },
      experimental = {
        classRegex = {"class_ \"([^\"]*)"}
      }
    }
  }
})

vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
