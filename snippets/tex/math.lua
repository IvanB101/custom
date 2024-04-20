local ls = require("luasnip")
local s = ls.snippet -- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep
-- local line_begin = require("luasnip.extras.expand_conditions").line_begin

local in_mathzone = function()
    -- The `in_mathzone` function requires the VimTeX plugin
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
    -- Another take on the fraction snippet without using a regex trigger
    s({ trig = "ff" },
        fmta(
            "\\frac{<>}{<>}",
            {
                i(1),
                i(2),
            }
        ),
        { condition = in_mathzone } -- `condition` option passed in the snippet `opts` table
    ),
}
