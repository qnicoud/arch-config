return {
    "rcarriga/nvim-notify",
    opts = {
        -- add any options here
    },

    config = function()
        local notify = require("notify")

        notify.setup({
            background_color = "#000000",
        })
    end,
}
