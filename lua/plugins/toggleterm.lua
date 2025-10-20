return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    {
      '<C-j>',
      '<cmd>ToggleTerm<cr>',
      desc = 'Toggle terminal',
    },
  },
  opts = {
    direction = 'horizontal',
    open_mapping = [[<C-j>]],
    size = 20,
    shade_terminals = true,
    shading_factor = 2,
  },
}
