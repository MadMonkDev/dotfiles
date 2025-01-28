return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[      __  __           _ __  __             _      ____                 ]],
      [[     |  \/  | __ _  __| |  \/  | ___  _ __ | | __ |  _ \  _____   __    ]],
      [[     | |\/| |/ _` |/ _` | |\/| |/ _ \| '_ \| |/ / | | | |/ _ \ \        ]],
      [[     | |  | | (_| | (_| | |  | | (_) | | | |   < _| |_| |  __/\ V /     ]],
      [[     |_|  |_|\__,_|\__,_|_|  |_|\___/|_| |_|_|\_(_)____/ \___| \_/      ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    alpha.setup(dashboard.opts)
  end,
}
