--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.keys.normal_mode["gt"] = ":pop<cr>"
lvim.keys.normal_mode["K"] = ":lua require'lspsaga.hover'.render_hover_doc()<CR>"

-- Change theme settings
lvim.colorscheme = "noctis"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true 
lvim.builtin.treesitter.rainbow.enable = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.telescope.defaults.layout_strategy = 'vertical'
lvim.builtin.telescope.defaults.layout_config = {
  width = 0.95, -- 0.90,
  height = 0.95,
  -- preview_height = 0.5,
}


lvim.builtin.dap.active = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.g.italic_comments = true -- italic comments(Default: true)
vim.g.italic_keywords = true -- italic keywords(Default: true)
vim.g.italic_functions = true -- italic functions(Default: false)
vim.g.italic_variables = true -- italic variables(Default: false)
vim.g.haskell_enable_quantification = true
vim.g.haskell_enable_recursivedo = true 
vim.g.haskell_enable_arrowsyntax = true 
vim.g.haskell_enable_pattern_synonyms = true
vim.g.haskell_enable_static_pointers = true 
vim.g.neoformat_enabled_haskell = {'fourmolu'}



vim.cmd([[
  autocmd FileType Outline setlocal signcolumn=no 
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
]])

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua" },
  {
    command = "prettier",
    extra_args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    args = { "--severity", "warning" },
  },
}

lvim.plugins = {
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "dinhhuy258/git.nvim", config = function() require('git').setup() end },
  { 'kartikp10/noctis.nvim', dependencies = { 'rktjmp/lush.nvim' } },
  { "folke/todo-comments.nvim", config = function() require("todo-comments").setup {} end },
  { "gpanders/editorconfig.nvim" },
  { "j-hui/fidget.nvim", config = function() require "fidget".setup {} end },
  { "junegunn/vim-easy-align" },
  { "m-demare/hlargs.nvim", config = function() require('hlargs').setup() end }, -- highlight arguments
  { "nathom/filetype.nvim" },
  { "ndmitchell/ghcid", rtp = "plugins/nvim" },
  { "neovimhaskell/haskell-vim" },
  { "tpope/vim-repeat" },
  { "ggandor/leap.nvim", config = function() require('leap').add_default_mappings() end },
  { 'nacro90/numb.nvim', config = function() require "numb".setup {} end },
  { 'MrcJkb/haskell-tools.nvim' },
  { "p00f/nvim-ts-rainbow" },
  { "ray-x/lsp_signature.nvim", config = function() require "lsp_signature".setup {} end},
  { "romgrk/nvim-treesitter-context" },
  { "sbdchd/neoformat" },
  { "simrat39/symbols-outline.nvim", config = function() require('symbols-outline').setup() end },
  { "sindrets/diffview.nvim", event = "BufRead" },
  { "stevearc/dressing.nvim" },
  { "wakatime/vim-wakatime" },
  { "xiyaowong/nvim-transparent" },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    }
  },
  { 'ray-x/guihua.lua' },
  { 'ray-x/sad.nvim', config = function()
    require 'sad'.setup({
      diff = 'delta', -- you can use `diff`, `diff-so-fancy`
      ls_file = 'fd', -- also git ls_file
      exact = false, -- exact match
      vsplit = true, -- split sad window the screen vertically, when set to number
      -- it is a threadhold when window is larger than the threshold sad will split vertically,
      height_ratio = 0.6, -- height ratio of sad window when split horizontally
      width_ratio = 0.6, -- height ratio of sad window when split vertically

    })
  end },
  { 'chentoast/marks.nvim', config = function() require 'marks'.setup {} end },
  {
    "nvim-neotest/neotest",
    dependencies = { "MrcJkb/neotest-haskell", },
    config = function()
      require("neotest").setup({ adapters = { require("neotest-haskell"), } })
    end
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      -- Update this path
      -- local extension_path = vim.env.HOME .. 'codelib/'
      -- local codelldb_path = extension_path .. 'adapter/codelldb'
      -- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

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
          cmd_env = {
            CARGO_TARGET_DIR = '/Users/tonyalaribe.parity/rust-analyzer'
          },
          settings = {
            ["rust-analyzer"] = {
              server = {
                extraEnv = {
                  -- Only used in VS Code
                  CARGO_TARGET_DIR = '/Users/tonyalaribe.parity/rust-analyzer'
                },
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate"
              },
              cargo = {
                allFeatures = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = {
                enable = false,
                extraArgs = { "--target-dir", "/Users/tonyalaribe.parity/rust-analyzer" },
                -- default: `cargo check`
                command = "clippy"
              },
              diagnostics = {
                disable = { "unresolved-proc-macro" }
              },
              rustfmt = {
                extraArgs = { "+nightly", },
              },
              procMacro = {
                enable = true,
                attributes = {
                  enable = true
                }
                -- server = ""
              }
            },
            inlayHints = {
              lifetimeElisionHints = {
                enable = true,
                useParameterNames = true
              },
            },
          }
        },
        -- debugging stuff
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
          -- adapter = {
          --   type = "executable",
          --   command = "lldb-vscode",
          --   name = "rt_lldb",
          -- },
        },
      }
      -- WARNING: I did not try to get debugging working at all,
      -- hence things being commented out.
      -- See: https://github.com/LunarVim/LunarVim/issues/2894
      -- local extension_path = vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.3/"
      -- local codelldb_path = extension_path .. "adapter/codelldb"
      -- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      --
      local extension_path = vim.env.HOME .. 'codelib/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
      opts.dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      }
      rust_tools.setup(opts)
      rust_tools.inlay_hints.enable()
    end,
    ft = { "rust", "rs" },
  },
}

lvim.builtin.which_key.mappings["i"] = {
  name = "Saga",
  r = { "<cmd>lua require'lspsaga.rename'.rename()<CR>", "Rename" },
  K = { "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>", "Hover Doc" },
  f = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", "Find Via LSP" },
  a = { "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", "Code action" },
  k = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", "Preview Definition" },
  d = { "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", "line diagnostic" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "Rust",
  m = { "<cmd>RustExpandMacro<cr>", "Expand Macro" },
  r = { "<cmd>RustRunnables<cr>", "Runnables" },
  rr = { "<cmd>RustLastRun<cr>", "Last Run" },
  he = { "<cmd>RustEnableInlayHints<cr>", "Enable Inlay Hints" },
  hd = { "<cmd>RustDisableInlayHints<cr>", "Disable Inlay Hints" },
  hE = { "<cmd>RustSetInlayHints<cr>", "Enable Inlay Hints All buffs" },
  hD = { "<cmd>RustUnsetInlayHints<cr>", "Disable Inlay Hints All buffs" },
  K = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
  Kr = { "<cmd>RustHoverRange<cr>", "Hover Range" },
  a = { "<cmd>RustCodeAction<cr>", "Rust Code Actions" },
  f = { "<cmd>RustFmt<cr>", "Rust Fmt" },
  fr = { "<cmd>RustFmtRange<cr>", "Rust Fmt Range" },
  d = { "<cmd>RustDebuggables<cr>", "Rust Debuggables" },


}

-- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "fourmolu",
    args = { "-i" },
    filetypes = { "haskell", "hs" },
  },
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
