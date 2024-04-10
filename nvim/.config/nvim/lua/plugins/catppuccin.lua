-- catppuccin.lua

return {

    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function ()
        local catppuccin = require("catppuccin")
        catppuccin.setup({
            color_overrides = {
                mocha = {
                    base = "#000000",
                    mantle = "#000000",
                    crust = "#000000",
                },
            },
        })
    end

}

