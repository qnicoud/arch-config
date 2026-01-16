return {
  "shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    -- chargement du thème
    vim.cmd([[colorscheme ayu-dark]])
  end,
}
