-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	    {
		{
		  "christoomey/vim-tmux-navigator",
		  cmd = {
		    "TmuxNavigateLeft",
		    "TmuxNavigateDown",
		    "TmuxNavigateUp",
		    "TmuxNavigateRight",
		    "TmuxNavigatePrevious",
		  },
		  keys = {
		    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		  },
		}
	    },
	    {
		    'nvim-telescope/telescope.nvim', tag = '0.1.8'
	    },
	    {
				'neovim/nvim-lspconfig',
	    },
			{
				'hrsh7th/cmp-nvim-lsp'
			},
			{
				'hrsh7th/nvim-cmp'
			},
			{
				'L3MON4D3/LuaSnip'
			},
			{
				'williamboman/mason.nvim'
			},
			{
				'williamboman/mason-lspconfig.nvim'
			},
			{
				'rose-pine/neovim', name = 'rose-pine'
			},
			{
				'tomasiser/vim-code-dark'
			},
			{
				'ayu-theme/ayu-vim'
			},
			{
				'sainnhe/gruvbox-material'
			},
			{
				'Eandrju/cellular-automaton.nvim'
			},
			{
				'nvim-tree/nvim-tree.lua'
			},
			{
				'ray-x/lsp_signature.nvim',
				event="InsertEnter",
				opts={
					bind=true,
					handler_opts={
						border="rounded"
					},
					hint_prefix = {
						above = "↙ ",  -- when the hint is on the line above the current line
						current = "← ",  -- when the hint is on the same line
						below = "↖ "  -- when the hint is on the line below the current line
					}
				},
				config = function(_, opts) require'lsp_signature'.setup(opts) end
			},
			{
				'powerman/vim-plugin-AnsiEsc'
			},
			{
				'tpope/vim-dispatch'
			},
			{
				'rmagatti/auto-session',
				lazy = false,

				---enables autocomplete for opts
				---@module "auto-session"
				---@type AutoSession.Config
				opts = {
					suppressed_dirs = { '~/', '~/Downloads', '/' },
					-- log_level = 'debug',
				}
			}
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
local nvim_tree_api = require("nvim-tree.api")
require('nvim-tree').setup({
	view = {adaptive_size = true, relativenumber = true},
	renderer = {
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = false,
				git = false,
				modified = false,
				diagnostics = false
			}
		}
	}

})

vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', {})


require('mason').setup()
require('mason-lspconfig').setup()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.timeoutlen = 190
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set({'i', 'n'}, '<C-s>', '<cmd>update<cr><esc>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader><leader>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}
--lspconfig.java_language_server.setup{}
lspconfig.clangd.setup{}

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = {buffer = true}
			vim.keymap.set(mode, lhs, rhs, opts)
		end
	bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
	 -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
	end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.ts_ls.setup({
	capabilities = lsp_capabilities
})


vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
	expand = function(args)
		luasnip.lsp_expand(args.body)
	end,
	sources = {
		{name='path'},
		{name = 'nvim_lsp', keyword_length= 1},
		{name = 'buffer', keyword_length= 3},
		{name = 'luasnip', keyword_length= 2},
	},
	formatting ={
		fields = {'menu', 'abbr', 'kind'}
	},
	formatting = {
		fields = {'menu', 'abbr', 'kind'},
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),
		['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
		['<C-n>'] = cmp.mapping.select_next_item(select_opts),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = cmp.mapping.confirm({select=true}),
		['<CR>'] = cmp.mapping.confirm({select=false}),
		['<C-f>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {'i', 's'}),
		['<C-b>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),
		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			else
				cmp.complete()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, {'i', 's'}),
	}
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true
})

--vim.api.nvim_set_hl(0, 'Comment', { italic = true })

vim.api.nvim_set_hl(0, 'Conditional', { italic = true })
vim.api.nvim_set_hl(0, 'Repeat', { italic = true })
vim.api.nvim_set_hl(0, 'Label', { italic = true })
vim.api.nvim_set_hl(0, 'Operator', { italic = true })
vim.api.nvim_set_hl(0, 'keyword', { italic = true })
vim.api.nvim_set_hl(0, 'Exception', { italic = true })

vim.api.nvim_set_hl(0, 'Type', { italic = true })
vim.api.nvim_set_hl(0, 'StorageClass', { italic = true })
vim.api.nvim_set_hl(0, 'Structure', { italic = true })
vim.api.nvim_set_hl(0, 'Typedef', { italic = true })

--[[
vim.api.nvim_set_hl(0, 'PreProc', { italic = true })

vim.api.nvim_set_hl(0, 'Special', { italic = true })
vim.api.nvim_set_hl(0, 'SpecialChar', { italic = true })
vim.api.nvim_set_hl(0, 'Tag', { italic = true })
vim.api.nvim_set_hl(0, 'Delimiter', { italic = true })
vim.api.nvim_set_hl(0, 'Debug', { italic = true })
--]]
--


vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'})

--vim.cmd.colorscheme('darkblue')
--vim.cmd.colorscheme('gruvbox-material')
--
vim.keymap.set("n", "<leader>r", ":w | :!python3 %<CR>")

vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.expand("%:p") -- Full path is safer
  local cmd = "python3 " .. file .. " 2>&1"
  local output = vim.fn.systemlist(cmd)
end)
