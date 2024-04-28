local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({
    "folke/tokyonight.nvim",
    "folke/which-key.nvim",
    { 
        "folke/neoconf.nvim", 
        cmd = "Neoconf" 
    },
    "folke/neodev.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    { 
        "rose-pine/neovim", 
        name = "rose-pine",
        config = function() 
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    }
})
