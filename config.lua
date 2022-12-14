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
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shell = "bash --rcfile ~/.profile"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- This is required to not have cue files marked as `cuesheet`
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.cue" },
  command = "set filetype=cue",
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cue = {
  install_info = {
    url = "https://github.com/eonpatapon/tree-sitter-cue", -- local path or git repo
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main"
  },
  filetype = "cue", -- if filetype does not agrees with parser name
}

-- treesitter.setup {
--   ensure_installed = {
--     "cue",
--   }
-- }
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cue",
--   callback = function()
--     require("nvim-treesitter.highlight").attach(0, "cue")
--   end,
-- })

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
  "java",
  "yaml",
  "cue",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
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

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { command = "black", filetypes = { "python" } },
  -- { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    -- filetypes = { "css", "typescript", "typescriptreact" },
    filetypes = { "css", "dot", "graphviz" },
  },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

lvim.plugins = {
  { "ellisonleao/gruvbox.nvim" },
  -- { "folke/tokyonight.nvim" },
  -- { "marko-cerovac/material.nvim" },
  -- { "sainnhe/sonokai" },

  {
    "tpope/vim-surround",
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --   vim.o.timeoutlen = 500
    -- end
  },
  -- {
  --   "mattn/webapi-vim",
  -- },
  -- {
  --   "mattn/vim-gist",
  --   event = "BufRead",
  -- },
  {
    'edolphin-ydf/goimpl.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require 'telescope'.load_extension 'goimpl'
    end,
  },
  {
    "fatih/vim-go",
  },
  {
    'ibhagwan/fzf-lua'
  },
  {
    'nkrkv/nvim-treesitter-rescript',
  },
  {
    'bantana/vim-present',
  },
  {
    'christoomey/vim-tmux-navigator',
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "javascriptreact", "typescriptreact" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "AndrewRadev/tagalong.vim",
  },
  {
    'liuchengxu/graphviz.vim',

  },
  {
    -- 'nvim-lua/plenary.nvim',
    'akinsho/flutter-tools.nvim',
  },
  {
    "brymer-meneses/grammar-guard.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "williamboman/nvim-lsp-installer"
    }
  }
}
require 'lspconfig'.bufls.setup {}
vim.api.nvim_set_keymap('n', '<c-P>',
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-I>',
  "<cmd>FzfLua<CR>",
  { noremap = true, silent = true })

require("grammar-guard").init()

require("lspconfig").ltex.setup {
  cmd = { '/Users/bantana/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls' },
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib", "markdown", "dot" },
      language = "en",
      diagnosticSeverity = "information",
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en",
      },
      trace = { server = "verbose" },
      -- dictionary = { ['en-US'] = { 'perf', 'ci' }, },
      dictionary = {},
      disabledRules = {},
      hiddenFalsePositives = {},
    },
  },
}
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "css", "scss" },
--   -- enable wrap mode for json files only
--   command = "ColorizerToggle",
-- })


-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
local lspconfig = require("lspconfig")
lspconfig.emmet_ls.setup({
  -- capabilities = capabilities,
  -- on_attach = on_attach,
  filetypes = { "html", "css", "javascript", "typescriptreact", "javascriptreact", "terraform" },
})

local opts = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '???', '???' },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = { "<Esc>", "q" },
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { icon = "???", hl = "TSURI" },
    Module = { icon = "???", hl = "TSNamespace" },
    Namespace = { icon = "???", hl = "TSNamespace" },
    Package = { icon = "???", hl = "TSNamespace" },
    Class = { icon = "????", hl = "TSType" },
    Method = { icon = "??", hl = "TSMethod" },
    Property = { icon = "???", hl = "TSMethod" },
    Field = { icon = "???", hl = "TSField" },
    Constructor = { icon = "???", hl = "TSConstructor" },
    Enum = { icon = "???", hl = "TSType" },
    Interface = { icon = "???", hl = "TSType" },
    Function = { icon = "???", hl = "TSFunction" },
    Variable = { icon = "???", hl = "TSConstant" },
    Constant = { icon = "???", hl = "TSConstant" },
    String = { icon = "????", hl = "TSString" },
    Number = { icon = "#", hl = "TSNumber" },
    Boolean = { icon = "???", hl = "TSBoolean" },
    Array = { icon = "???", hl = "TSConstant" },
    Object = { icon = "???", hl = "TSType" },
    Key = { icon = "????", hl = "TSType" },
    Null = { icon = "NULL", hl = "TSType" },
    EnumMember = { icon = "???", hl = "TSField" },
    Struct = { icon = "????", hl = "TSType" },
    Event = { icon = "????", hl = "TSType" },
    Operator = { icon = "+", hl = "TSOperator" },
    TypeParameter = { icon = "????", hl = "TSParameter" }
  }
}

require("lvim.lsp.manager").setup("pyright", opts)

lvim.builtin.which_key.mappings.l = vim.tbl_extend("keep", lvim.builtin.which_key.mappings.l,
  {
    o = { "<cmd>SymbolsOutline<cr>", "Open Outline" }
  }
)

lvim.lsp.diagnostics.virtual_text = true

-- If does not exist, graphviz.vim will automatically choose the right way depending on the platform.
-- {svg viewer Gapplin install from AppStore, Preferences... -> { Auto-Redraw(selected), External editor:(vimr) }
-- {pdf viewer `brew install skim`, Preferences -> Check for file changes -> Reload automatically(selected)}
vim.g.graphviz_viewer = 'open'
-- Options passed on to dot. Default is ''.
vim.g.graphviz_shell_option = ''
-- `.format` is 'pdf' by default.
-- Option: 'ps', 'pdf', 'png', 'jpg', 'gif', 'svg'
vim.g.graphviz_output_format = 'svg'
vim.api.nvim_set_keymap('n', '<localleader>bg', [[<cmd>GraphvizCompile<CR>]],
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<localleader>t', [[<cmd>ToggleTerm<CR>]],
  { noremap = true, silent = true })


lvim.colorscheme = "tokyonight-moon"
lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git/", "node_modules/", ".cache", "%.o", "%.a", "%.out" }
vim.g.go_alternate_mode = "edit"

require("telescope").load_extension("flutter")
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>Telescope flutter commands<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>FlutterOutlineToggle<CR>]],
  { noremap = true, silent = true })

-- require("flutter-tools").setup {} -- use defaults
-- alternatively you can override the default configs
require("flutter-tools").setup {
  flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
      vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { buffer = args.buf })
    end,
  })
}

vim.api.nvim_set_keymap('n', '<leader>g', [[Go]],
  { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>gi', [[<cmd>GoImpl<CR>]],
--   { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ga', [[<cmd>GoAlternate!<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gr', [[<cmd>GoRename<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gt', [[:GoAddTags ]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>GoFillStruct<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gm', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
  { noremap = true, silent = true })
