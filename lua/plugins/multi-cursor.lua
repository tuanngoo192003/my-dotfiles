return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      -- Override default mappings
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",         -- Select next match (like VS Code Ctrl+D)
        ["Find Subword Under"] = "<C-d>", -- Select partial word matches too
      }
    end,
  },
}
