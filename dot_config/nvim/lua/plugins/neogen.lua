return {
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
        {
            "<leader>rd",
            function()
                require("neogen").generate({})
            end,
            desc = "Generate annotation",
        },
    },
    opts = { snippet_engine = "luasnip" },
}
