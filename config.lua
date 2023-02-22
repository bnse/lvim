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
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["m"] = {
	m = { "<cmd>SymbolsOutline<CR>", "SymbolsOutline" },
	g = { "<cmd>GraphvizCompile<CR>", "GraphvizCompile" },
	e = { "<cmd>LeanInfoviewToggle<CR>", "LeanInfoviewToggle" },
}
lvim.builtin.which_key.mappings["o"] = {
	name = "octo",
	i = { "<cmd>Octo issue list<CR>", "List all issues" },
}
lvim.builtin.which_key.mappings["t"] = {
	name = "Translate",
	t = { "<cmd>Translate zh<CR>", "Translate" },
	r = { "<cmd>Translate en -output=replace<CR>", "Translate to English and replace" },
	c = { "<cmd>Translate zh -output=replace<CR>", "Translate to Chinese and replace" },
	b = { "<cmd>ToggleTerm<CR>", "Terminal" },
	p = { "<cmd>Telescope projects<CR>", "Projects" },
}
lvim.builtin.which_key.mappings["="] = { "<cmd>vertical resize +50<cr>", "pane vertical resize +50" }
lvim.builtin.which_key.mappings["-"] = { "<cmd>vertical resize -50<cr>", "pane vertical resize -50" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"
-- lvim.colorscheme = "tokyonight-moon"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
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

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "goimports", filetypes = { "go" } },
	{ command = "gofumpt", filetypes = { "go" } },
	-- { command = "lua-format", filetypes = { "lua" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "prettier", filetypes = { "dot" } },
	-- { command = "format_lean", filetypes = { "lean" } },
})
lvim.format_on_save = { pattern = { "*.go" } }
-- lvim.format_on_save = {pattern = {"*.go"}}
lvim.format_on_save = true

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }
lvim.plugins = {
	{
		-- "folke/tokyonight.nvim",
	},
	{
		"tpope/vim-surround",
	},
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"rescript-lang/vim-rescript",
		"nkrkv/nvim-treesitter-rescript",
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				position = "left",
				relative_width = true,
			})
		end,
		cmd = "SymbolsOutline",
	},
	{
		"uga-rosa/translate.nvim",
		-- 'uga-rosa/cmp-dictionary'
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"olexsmir/gopher.nvim",
	},
	{
		"edolphin-ydf/goimpl.nvim",
		-- requires = {
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("telescope").load_extension("goimpl")
		end,
	},
	{
		"fatih/vim-go",
	},
	{
		"liuchengxu/graphviz.vim",
	},
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"brymer-meneses/grammar-guard.nvim",
		-- requires = {
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
		},
	},
	-- {
	--     "bantana/vim-present",
	-- },
	{
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
		end,
	},
	{
		"Julian/lean.nvim",
		-- dependencies = {
		-- 	"andrewradev/switch.vim",
		-- },
	},
}
require("grammar-guard").init()

require("lspconfig").ltex.setup({
	-- cmd = { '/usr/local/bin/ltex-ls' },
	settings = {
		ltex = {
			enabled = { "latex", "org", "tex", "bib", "markdown", "dot", "slide", "article", "octo" },
			language = "en",
			diagnosticSeverity = "information",
			setenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "en",
			},
			trace = { server = "verbose" },
			flags = { debounce_text_changes = 300 },
			dictionary = { ["en-US"] = { "perf", "ci" } },
			-- dictionary = {},
			disabledRules = {},
			hiddenFalsePositives = {},
		},
	},
})

require("lvim.lsp.manager").setup("emmet_ls")
local lspconfig = require("lspconfig")
lspconfig.emmet_ls.setup({
	filetypes = { "html", "rescript", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})

lvim.builtin.terminal.active = true
lvim.builtin.terminal.shell = "bash --rcfile ~/.profile"

require("translate").setup({
	defalut = {
		command = "translate_shell",
		output = "floating",
		relative_width = 25,
	},
	preset = {
		output = {
			insert = {
				base = "top",
				off = -1,
			},
		},
	},
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
	return
end

gopher.setup({
	commands = {
		go = "go",
		gomodifytags = "gomodifytags",
		gotests = "gotests",
		impl = "goimpl",
		iferr = "iferr",
	},
})

lvim.builtin.which_key.mappings["G"] = {
	name = "Go",
	a = { "<cmd>GoAlternate<CR>", "GoAlternate" },
	i = { "<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>", "GoImpl" },
	I = { "<cmd>GoInstallDeps<cr>", "Install Go Dependencies" },
	m = { "<cmd>GoMod tidy<cr>", "Tidy" },
	t = {
		name = "Test",
		a = { "<cmd>GoAlternate<cr>", "Add Test" },
		s = { "<cmd>GoTestsAll<cr>", "Add All Tests" },
		e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
		f = { "<cmd>GoTestFunc<CR>", "GoTestFunc" },
	},
	-- g = {
	--   name = "Generate",
	--   -- c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
	--   -- f = { "<cmd>GoGenerate %<cr>", "Go Generate File" },
	--   -- g = { "<cmd>GoGenerate<cr>", "Go Generate" },
	-- },
	-- d = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" },
	e = { "<cmd>GoIfErr<cr>", "GoIfErr" },
	s = { "<cmd>IndentBlanklineToggle<cr>", "IndentBlanklineToggle" },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })

vim.g.graphviz_viewer = "open"
-- Options passed on to dot. Default is ''.
vim.g.graphviz_shell_option = ""
-- `.format` is 'pdf' by default.
-- Option: 'ps', 'pdf', 'png', 'jpg', 'gif', 'svg'
vim.g.graphviz_output_format = "svg"

vim.opt.termguicolors = true
lvim.builtin.indentlines.options.enabled = false

vim.opt.textwidth = 80
vim.opt.wrapmargin = 1
vim.opt.colorcolumn = "-2"

lvim.reload_config_on_save = false

vim.opt.spell = true
vim.opt.spelllang = { "en" }

vim.filetype.add({
	extension = {
		slide = "markdown",
	},
})
vim.filetype.add({
	extension = {
		article = "markdown",
	},
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

local ft = require("Comment.ft")
ft.rescript = { "//%s", "/*%s*/" }

---- Always show sign column.
-- The sign column is used by the LSP support to show diagnostics
-- (the E, W, etc. characters on the side)
-- as well as by the Lean plugin to show the orange bars.
-- By default the sign column is only shown if there are signs to show,
-- which means the buffer will constantly jump right and left.
vim.opt.signcolumn = "yes:1"

-- Enable nvim-cmp, with 3 completion sources, including LSP
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	}),
})

-- You may want to reference the nvim-cmp documentation for further
-- configuration of completion: https://github.com/hrsh7th/nvim-cmp#recommended-configuration

-- Configure the language server:

-- You may want to reference the nvim-lspconfig documentation, found at:
-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
-- The below is just a simple initial set of mappings which will be bound
-- within Lean files.
local function on_attach(_, bufnr)
	local function cmd(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = true })
	end

	-- Autocomplete using the Lean language server
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- gd in normal mode will jump to definition
	cmd("n", "gd", vim.lsp.buf.definition)
	-- K in normal mode will show the definition of what's under the cursor
	cmd("n", "K", vim.lsp.buf.hover)

	-- <leader>n will jump to the next Lean line with a diagnostic message on it
	-- <leader>N will jump backwards
	cmd("n", "<leader>n", function()
		vim.lsp.diagnostic.goto_next({ popup_opts = { show_header = false } })
	end)
	cmd("n", "<leader>N", function()
		vim.lsp.diagnostic.goto_prev({ popup_opts = { show_header = false } })
	end)

	-- <leader>K will show all diagnostics for the current line in a popup window
	cmd("n", "<leader>K", function()
		vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })
	end)

	-- <leader>q will load all errors in the current lean file into the location list
	-- (and then will open the location list)
	-- see :h location-list if you don't generally use it in other vim contexts
	-- cmd("n", "<leader>q", vim.lsp.diagnostic.set_loclist)
end

-- Enable lean.nvim, and enable abbreviations and mappings
require("lean").setup({
	abbreviations = { builtin = true },
	lsp = { on_attach = on_attach },
	-- lsp3 = { on_attach = on_attach },
	mappings = true,
})

-- Update error messages even while you're typing in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = { spacing = 4 },
	update_in_insert = true,
})
