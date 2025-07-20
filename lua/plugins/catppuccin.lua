-- return {
--   "2giosangmitom/nightfall.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {}, -- Add custom configuration here
--   config = function(_, opts)
--     require("nightfall").setup(opts)
--     vim.cmd("colorscheme nightfall") -- Choose from: nightfall, deeper-night, maron, nord
--   end,
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    })

    -- Set the colorscheme
    vim.cmd.colorscheme("catppuccin")
    end,
}

