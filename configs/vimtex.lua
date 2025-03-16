-- Viewer options: One may configure the viewer either by specifying a built-in
-- viewer method:
vim.g.vimtex_view_method = "zathura"
-- Or with a generic interface:
vim.g.vimtex_view_general_viewer = 'okular'

-- This is necessary for VimTeX to load properly. The "indent" is optional.
-- Note: Most plugin managers will do this automatically!
-- filetype plugin indent on

-- Most VimTeX mappings rely on localleader and this can be changed with the
-- following line. The default is usually fine and is the symbol "\".
vim.maplocalleader = ","

vim.g.vimtex_compiler_latexmk = {
    out_dir = 'build'
}
