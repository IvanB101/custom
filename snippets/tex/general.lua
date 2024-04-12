local ls = require("luasnip")
local s = ls.snippet -- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end

-- Using a multiline string for the equation snippet
return {
    s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" },
        fmta(
            "\\texttt{<>}",
            { i(1) }
        )
    ),
    s({ trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'" },
        fmt(
            "\\frac{<>}{<>}",
            {
                i(1),
                i(2)
            },
            { delimiters = "<>" } -- manually specifying angle bracket delimiters
        )
    ),
    s({ trig = "eq", dscr = "A LaTeX equation environment" },
        fmta(
            [[
              \begin{equation*}
                  <>
              \end{equation*}
            ]],
            { i(1) }
        )
    ),
    s({ trig = ";env", snippetType = "autosnippet" },
        fmta(
            [[
              \begin{<>}
                  <>
              \end{<>}
            ]],
            {
                i(1),
                i(2),
                rep(1),
            }
        )
    ),
    s({ trig = "eq", dscr = "" },
        fmta(
            [[
              \begin{equation}
                  <>
              \end{equation}
            ]],
            { i(0) }
        )
    ),
    s({ trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "<>_{<>}",
            {
                f(function(_, snip) return snip.captures[1] end),
                t("0")
            }
        )
    ),
    s({ trig = "h1", dscr = "Top-level section" },
        fmta(
            [[\section{<>}]],
            { i(1) }
        ),
        { condition = line_begin }
    ),
    s({ trig = "new", dscr = "A generic new environmennt" },
        fmta(
            [[
      \begin{<>}
          <>
      \end{<>}
    ]],
            {
                i(1),
                i(2),
                rep(1),
            }
        ),
        { condition = line_begin }
    ),
}
