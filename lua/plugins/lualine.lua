return {
  'nvim-lualine/lualine.nvim',
  config = function()

    require('lualine').setup({
      options = {
        icons_enabled = true, -- Enable icons in the statusline
        theme = 'catppuccin', -- Choose your preferred theme
        component_separators = {'|', '|'},
        section_separators = {'', ''},
        disabled_filetypes = {'NvimTree', 'dashboard'}, -- Disable in these filetypes
      },
      sections = {
        lualine_a = {'mode'}, -- First section: Mode (Normal, Insert, etc.)
        lualine_b = {'branch'}, -- Second section: Git branch
        lualine_c = {          -- Third section: Filename, Date/Time, Weather
          "filename",
          {
            function()
                local utc_time = os.time(os.date("!*t")) 
                local time_stamp = utc_time + 7 * 60 * 60
                return os.date("%d-%m-%y %H:%M", time_stamp)
            end,
          },
          {
            function()
                local temp = 24.0
                local icon = "❓"

                local utc_time = os.time(os.date("!*t")) 
                local time_stamp = utc_time + 7 * 60 * 60
                local hour = tonumber(os.date("%H", time_stamp))

                if hour >= 24 then hour = hour - 24 end

                if hour >= 5 and hour < 8 then
                  icon = "🌅" -- Morning
                elseif hour >= 8 and hour < 12 then
                  icon = "🌤️" -- Noon
                elseif hour >= 12 and hour < 17 then
                  icon = "☀️" -- Afternoon
                elseif hour >= 17 and hour < 19 then
                  icon = "🌇" -- Sunset
                elseif hour >= 19 and hour < 22 then
                  icon = "🌆" -- Evening
                else
                  icon = "🌙" -- Night
                end

                return string.format("%s %.1f°C", icon, temp)
            end,
          },
        },
        lualine_x = {
            {
                function()
                    return 'Tuanngoo_'
                end,
                color = { fg = '#9e4f34' },
                padding = { left = 1, right = 1 },
            },
            'encoding', 
            'fileformat', 
            'filetype'
        }, -- Fourth section: Encoding, file format, filetype
        lualine_y = {'progress'}, -- Fifth section: Progress
        lualine_z = {'location'}, -- Sixth section: Location in the file
      },
      extensions = {'fugitive'}, -- Add git fugitive extension (if you need git integration)
    })
  end
}

