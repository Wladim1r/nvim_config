return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    {
      '<leader>t',
      '<cmd>ToggleTerm<cr>',
      desc = 'Toggle terminal',
    },
  },
  opts = {
    direction = 'horizontal',
    open_mapping = [[<leader>t]],
    size = 20,
    shade_terminals = true,
    shading_factor = 2,
  },
}
