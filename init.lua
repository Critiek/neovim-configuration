-- bootstrapping lazy.nvim for plugin management and installation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- setting up neovim settings and globals
vim.g.mapleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.cmd.set 'relativenumber'

vim.opt.showmode = false

-- lazy plugin manager setup and downloading/installing plugins
require('lazy').setup({
    {'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    {'nvim-lualine/lualine.nvim'},
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
	{
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {} -- this is equivalent to setup({}) function
	},
	{
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
	},
	-- Telescope and Fuzzy Finding
	{'nvim-lua/plenary.nvim'},
	{'nvim-telescope/telescope.nvim'},
	-- Nvim-Tree
	{'nvim-tree/nvim-tree.lua'},
	{'nvim-tree/nvim-web-devicons'},
	-- LSP Zero
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
})

-- setting colorscheme
vim.cmd.colorscheme 'catppuccin-mocha'

-- LSP zero config and setup
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

-- LSP zero setup for Neovim lua language server
local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

-- autocompletion keybindings
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),
	-- `Space` key to move down in completion menu
  })
})

-- treesitter setup and configuration
require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
	}
}

-- lualine setupp and configuration
require('lualine').setup()

-- nvim-tree setup and configuration
require('nvim-tree').setup()

-- setting up comment
require('Comment').setup()

-- telescope setup and configuration
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
