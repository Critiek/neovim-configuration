-- bootstrapping lazy.nvim for plugin management and installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- setting up neovim settings and globals
vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.cmd.set "relativenumber"

vim.opt.showmode = false

-- lazy plugin manager setup and downloading/installing plugins
require("lazy").setup({
	{"catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{"nvim-lualine/lualine.nvim"},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"windwp/nvim-autopairs", event = "InsertEnter", config = true},
	{"numToStr/Comment.nvim"},
	{"ms-jpq/chadtree"},
	{"b0o/mapx.nvim"},
	-- Telescope and Fuzzy Finding
	{"nvim-lua/plenary.nvim"},
	{"nvim-telescope/telescope.nvim"},
	-- Which key
	{"folke/which-key.nvim",
	  event = "VeryLazy",
	  init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	  end,
	  opts = {},
	},
})

-- setting colorscheme
vim.cmd.colorscheme "catppuccin-mocha"

require"nvim-treesitter.configs".setup {
  -- A list of parser names
  ensure_installed = { "c", "lua", "rust", "python", "markdown_inline", "json" },
  highlight = {
	  enable = "true",
  },
}

require'mapx'.setup{ global = true }

local wk = require("which-key")
wk.register(mappings, opts)

require('Comment').setup()

-- telescope setup and configuration
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

nnoremap("<leader>e", ":CHADopen<Cr>", "Open CHADtree")
nnoremap("<C-h>", "<C-W>h")
nnoremap("<C-l>", "<C-W>l")
