local builtin_plugs = {
	"gzip",
	"tar",
	"tarPlugin",
	"zip",
	"zipPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"matchit",
	"matchparen",
	"2html_plugin",
	"logiPat",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"tutor",
	"tohtml",
}

for i = 1, #builtin_plugs do
	vim.g["loaded_" .. builtin_plugs[i]] = true
end

local fn = vim.fn -- Autoinstall packer

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer, please restart Neovim...")
	vim.cmd([[ packadd packer.nvim ]])
end

-- Reload Neovim on plugins.lua save
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Pcall to be able to handle errors
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("Packer failed, please check your plugins.lua...")
	return
end

-- Popup window instead of a buffer
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install plugins
return packer.startup(function(use)
	-- plugins prerequisites
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })

	-- colors & themes
	use({ "Mofiqul/dracula.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "nvim-lualine/lualine.nvim" })

	-- autocompletion
	use({ "hrsh7th/nvim-cmp" }) -- completion engine
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) -- snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- snippets to use

	-- lsp
	use({ "williamboman/nvim-lsp-installer" }) -- easily install servers
	use({ "neovim/nvim-lspconfig" }) -- enable lsp
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- enable linters & stylers

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- misc
	use({ "nvim-telescope/telescope.nvim" }) -- Are you ready for a journey?
	use({ "windwp/nvim-autopairs" }) -- A decent auto pair for brackets
	use({ "numToStr/Comment.nvim" }) -- Easily comment stuff
	use({ "kyazdani42/nvim-tree.lua" }) -- NerdTree replacement
	use({ "akinsho/bufferline.nvim", tag = "v2.*" }) -- Visual buffers
	use({ "moll/vim-bbye" }) -- Close buffers without closing vim
	use({ "akinsho/toggleterm.nvim", tag = "v2.*" }) -- Better terminal
	use({ "lewis6991/impatient.nvim" }) -- speedup vim startup
	use({ "gbprod/yanky.nvim" }) -- Yank Improved
	use({ "iamcco/markdown-preview.nvim" })
	use({ "wakatime/vim-wakatime" })

	-- Autoconfigure after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
