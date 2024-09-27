return {
  'rmagatti/alternate-toggler',
  config = function()
    require('alternate-toggler').setup {
      alternates = {
        ['=='] = '!=',
      },
    }

    vim.keymap.set(
      'n',
      '<leader>ta', -- <space><space>
      "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>",
      { desc = '[S]earch [K]eymaps' }
    )
  end,
  event = { 'BufReadPost' }, -- lazy load after reading a buffer  'alexghergh/nvim-tmux-navigation',
}
