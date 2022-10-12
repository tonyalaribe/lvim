--[[
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT https://google.com

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.colorscheme = "darkplus"
lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "onedarker"

-- vim.g.transparent_background = true        -- transparent background(Default: false)
vim.g.italic_comments = true -- italic comments(Default: true)
vim.g.italic_keywords = true -- italic keywords(Default: true)
vim.g.italic_functions = true -- italic functions(Default: false)
vim.g.italic_variables = true -- italic variables(Default: false)
lvim.lsp.installer.setup.automatic_servers_installation = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "taplo", "rust_analyzer" })

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.ch = 0


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["gt"] = ":pop<cr>"
lvim.keys.normal_mode["K"] = ":lua require'lspsaga.hover'.render_hover_doc()<CR>"

require('telescope').load_extension('projects')

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
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

lvim.builtin.which_key.mappings["ss"] = { "<cmd>lua require('spectre').open()<CR>", "Open Search" }
lvim.builtin.which_key.mappings["sw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
  "Search word" }
lvim.builtin.which_key.vmappings["sw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
  "Search word" }

lvim.builtin.which_key.mappings["l?"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" }

-- TODO: User Config for predefined plugins
lvim.builtin.alpha.active = true
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- require("nvim-treesitter.install").compilers = { "gcc-11" }
-- lvim.builtin.treesitter.compilers = { "gcc-11" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
  "go",
  "haskell",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_netrw = true
vim.g.loaded_netrw = true -- or 1
vim.g.loaded_netrwPlugin = true -- or 1
lvim.builtin.treesitter.rainbow.enable = true

vim.cmd([[
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

  nmap <silent> <F3> :NvimTreeToggle<CR>
  nmap <silent> <F4> :SymbolsOutline<CR>
  "nmap <silent> <F4> :LSoutlineToggle<CR>

  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " zoom a vim pane, <C-w>= to re-balance
  nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
  nnoremap <leader>= :wincmd =<cr>

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  " vim.g.nvim_tree_disable_netrw = 0
]])


-- Additional Plugins
lvim.plugins = {
  { "David-Kunz/markid" },
  { "christoomey/vim-tmux-navigator" },
  { "dinhhuy258/git.nvim", config = function() require('git').setup() end },
  { "folke/lsp-colors.nvim", event = "BufRead" },
  { "folke/todo-comments.nvim", config = function() require("todo-comments").setup {} end },
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "glacambre/firenvim", run = function() vim.fn['firenvim#install'](0) end },
  { "gpanders/editorconfig.nvim" },
  { "j-hui/fidget.nvim", config = function() require "fidget".setup {} end },
  { "junegunn/vim-easy-align" },
  { "liuchengxu/vista.vim" },
  { "lunarvim/colorschemes" },
  { "m-demare/hlargs.nvim", config = function() require('hlargs').setup() end }, -- highlight arguments
  { "nathom/filetype.nvim" },
  { "ndmitchell/ghcid", rtp = "plugins/nvim" },
  { "neovimhaskell/haskell-vim" },
  { "p00f/nvim-ts-rainbow" },
  { "ray-x/lsp_signature.nvim", event = "BufRead", config = function() require("lsp_signature").setup() end },
  { "romgrk/nvim-treesitter-context" },
  { "sbdchd/neoformat" },
  { "simrat39/symbols-outline.nvim", config = function() require('symbols-outline').setup() end },
  { "sindrets/diffview.nvim", event = "BufRead" },
  { "stevearc/dressing.nvim" },
  { "tami5/lspsaga.nvim" },
  { "wakatime/vim-wakatime" },
  { "xiyaowong/nvim-transparent" },
  { 'echasnovski/mini.nvim' },
  { 'nvim-pack/nvim-spectre' },
  { 'chentoast/marks.nvim', config = function() require 'marks'.setup {} end },
  {
    "nvim-neotest/neotest",
    requires = { "MrcJkb/neotest-haskell", },
    config = function()
      require("neotest").setup({ adapters = { require("neotest-haskell"), } })
    end
  },
  { "ekickx/clipboard-image.nvim", config = function()
    require 'clipboard-image'.setup {
      default = {
        img_name = function()
          vim.fn.inputsave()
          local name = vim.fn.input('Name: ')
          vim.fn.inputrestore()
          if name == nil or name == '' then
            return os.date('%y-%m-%d-%H-%M-%S')
          end
          return name
        end,
      }
    }
  end
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local status_ok, rust_tools = pcall(require, "rust-tools")
      if not status_ok then
        return
      end
      local opts = {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            auto_focus = true,
          },
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          -- cmd = { "ra-multiplex" },
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        },
      }
      -- WARNING: I did not try to get debugging working at all,
      -- hence things being commented out.
      -- See: https://github.com/LunarVim/LunarVim/issues/2894
      -- local extension_path = vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.3/"
      -- local codelldb_path = extension_path .. "adapter/codelldb"
      -- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      -- opts.dap = {
      --        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      -- }
      rust_tools.setup(opts)
      rust_tools.inlay_hints.enable()
    end,
    ft = { "rust", "rs" },
  },
}

lvim.builtin.which_key.mappings["s"] = {
  name = "Search",
  b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
  f = { "<cmd>Telescope find_files<cr>", "Find File" },
  h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
  m = { "<cmd>Telescope marks<cr>", "Man Pages" },
  M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  R = { "<cmd>Telescope registers<cr>", "Registers" },
  t = { "<cmd>Telescope live_grep<cr>", "Text" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  C = { "<cmd>Telescope commands<cr>", "Commands" },
  p = {
    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
    "Colorscheme with Preview",
  },
}

lvim.builtin.which_key.mappings["l"] = {
  name = "LSP",
  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  A = { "<cmd>Lspsaga code_action<CR>", "Code Action saga" },
  d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
  w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
  f = { require("lvim.lsp.utils").format, "Format" },
  i = { "<cmd>LspInfo<cr>", "Info" },
  I = { "<cmd>Mason<cr>", "Mason Info" },
  j = {
    vim.diagnostic.goto_next,
    "Next Diagnostic",
  },
  k = {
    vim.diagnostic.goto_prev,
    "Prev Diagnostic",
  },
  l = { vim.lsp.codelens.run, "CodeLens Action" },
  q = { vim.diagnostic.setloclist, "Quickfix" },
  r = { vim.lsp.buf.rename, "Rename" },
  s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  S = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "Workspace Symbols",
  },
  e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
}

lvim.builtin.which_key.mappings["lt"] = {
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
  i = { "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>", "Hover Doc" },
  f = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", "Find Via LSP" },
  a = { "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", "Code action" },
  k = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", "Preview Definition" },
  d = { "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", "line diagnostic" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "Rust",
  m = { "<cmd>RustExpandMacro<cr>", "Expand Macro" },
  r = { "<cmd>RustRunnables<cr>", "Runnables" },
  he = { "<cmd>RustEnableInlayHints<cr>", "Enable Inlay Hints" },
  hd = { "<cmd>RustDisableInlayHints<cr>", "Disable Inlay Hints" },
  hE = { "<cmd>RustSetInlayHints<cr>", "Enable Inlay Hints All buffs" },
  hD = { "<cmd>RustUnsetInlayHints<cr>", "Disable Inlay Hints All buffs" },
  ha = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
}

lvim.builtin.which_key.mappings["h"] = {
  name = "Harpoon",
  a = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "mark file" },
  m = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "menu" },
}
lvim.builtin.which_key.mappings["h1"] = { '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', "open 1" }
lvim.builtin.which_key.mappings["h2"] = { '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', "open 2" }
lvim.builtin.which_key.mappings["h3"] = { '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', "open 3" }
lvim.builtin.which_key.mappings["h]"] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Nav next" }
lvim.builtin.which_key.mappings["h["] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Nav prev" }


-- local saga = require("lspsaga")
-- saga.init_lsp_saga()


vim.cmd([[
  " jump diagnostic
  nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
  nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
]])


lvim.builtin.which_key.mappings["z"] = {
  z = { '<cmd>lua require("stylua-nvim").format_file()<CR>', "Format Lua" },
}

require('lspconfig').tailwindcss.setup({
  filetypes = { "haskell", "html", "javascript" },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        haskell = "html"
      },
      experimental = {
        classRegex = { "class_ \"([^\"]*)" }
      }
    }
  }
})

require 'nvim-treesitter.configs'.setup {
  markid = { enable = true }
}

-- require("transparent").setup({
--   enable = true, -- boolean: enable transparent
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups

--     -- example of akinsho/nvim-bufferline.lua
--     "NvimTreeNormal",
--     "NvimTreeBg",
--     "all",
--   },
--   exclude = {}, -- table: groups you don't want to clear
-- })


require("symbols-outline").setup()

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local util = require 'lspconfig.util'

-- Check if the config is already defined (useful when reloading this file)
if not configs.doctests then
  configs.doctests = {
    default_config = {
      cmd = { 'doctests', 'lsp' };
      settings = {};
      filetypes = { 'go', 'gomod', 'gotmpl' },
      root_dir = function(fname)
        return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
      end,
      single_file_support = true,
    };
  }
end

lspconfig.doctests.setup {}

require('mini.ai').setup()
