local ls = require("luasnip")
local s = ls.snippet -- local sn = ls.snippet_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s({ trig = "cb", dscr = "code block" },
        fmta(
            [[
              \```{<>}
                  <>
              \```
            ]],
            { i(1), i(2) }
        )
    )
}
