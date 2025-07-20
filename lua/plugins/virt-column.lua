return {
  "lukas-reineke/virt-column.nvim",
  config = function()
    require("virt-column").setup({
      char = "│",       -- looks thinner than block
      virtcolumn = "120"
    })
  end,
}
