return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup({})
        end,
    },
}