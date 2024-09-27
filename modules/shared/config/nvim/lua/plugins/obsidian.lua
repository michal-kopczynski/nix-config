-- https://github.com/epwalsh/obsidian.nvim
--
-- example config: https://github.com/geekyHat/myKaliDot/blob/main/nvim/lua/geekynut/plugins/obsidian.lua
return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   'BufReadPre ~/vaults/dev',
  --   'BufNewFile ~/vaults/dev',
  -- },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'New Obsidian note', mode = 'n' },
    { '<leader>oj', '<cmd>ObsidianYesterday<cr>', desc = 'New daily note for yesterday', mode = 'n' },
    { '<leader>ok', '<cmd>ObsidianToday<cr>', desc = 'New daily note for today', mode = 'n' },
    { '<leader>ol', '<cmd>ObsidianTomorrow<cr>', desc = 'New daily note for tomorrow', mode = 'n' },

    { '<leader>oo', '<cmd>ObsidianSearch<cr>', desc = 'Search Obsidian notes', mode = 'n' },
    { '<leader>o;', '<cmd>ObsidianDailies<cr>', desc = 'Pick daily note', mode = 'n' },

    { '<leader>os', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick Switch', mode = 'n' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Show location list of backlinks', mode = 'n' },
    { '<leader>ot', '<cmd>ObsidianTemplate<cr>', desc = 'Insert a template from the templates folder', mode = 'n' },
    { '<leader>op', '<cmd>ObsidianPasteImg<cr>', desc = 'Paste image from clipboard under cursor', mode = 'n' },
    { '<leader>of', '<cmd>ObsidianFollowLink<cr>', desc = 'follows note under cursor', mode = 'n' },
    { '<leader>oe', '<cmd>ObsidianExtractNote<cr>', desc = 'Extracts visually selected note creates a new one with link', mode = 'n' },
    { '<leader>od', '<cmd>ObsidianToggleCheckbox<cr>', desc = 'Cycle through checkbox options.', mode = 'n' },
    -- workspaces https://github.com/epwalsh/obsidian.nvim/pull/155
    { '<leader>owd', '<cmd>ObsidianWorkspace dev<cr>', desc = 'Switch to workspace dev', mode = 'n' },
    { '<leader>ow1', '<cmd>ObsidianWorkspace pro1<cr>', desc = 'Switch to workspace pro1', mode = 'n' },
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    ui = { enable = false }, -- Disable UI as using render-markdown plugin instead

    workspaces = {
      {
        name = 'dev',
        path = '~/vaults/dev',
      },
      -- {
      --   name = 'pro1',
      --   path = '~/vaults/pro1',
      -- },
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = '_dailies',
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = '%Y-%m-%d',
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = '%B %-d, %Y',
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = 'daily.md',
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    -- Where to put new notes. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = 'notes_subdir',
    wiki_link_func = function(opts)
      print('what am I doing in wiki_link_func ', opts)
      if opts.id == nil then
        return string.format('[[%s]]', opts.label)
      elseif opts.label ~= opts.id then
        return string.format('[[%s|%s]]', opts.id, opts.label)
      else
        return string.format('[[%s]]', opts.id)
      end
    end,

    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = '', project = '' }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        print 'Title is empty!'
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      -- print(tostring(os.time()) .. '-' .. suffix)
      -- without timestamp
      return tostring(suffix)
    end,

    templates = {
      -- subdir = 'templates',
      folder = '~/vaults/templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      tags = '',
    },

    -- autosave
    callbacks = {
      -- Runs anytime you leave the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      ---@diagnostic disable-next-line: unused-local
      leave_note = function(client, note)
        vim.api.nvim_buf_call(note.bufnr or 0, function()
          vim.cmd 'silent w'
        end)
      end,
    },
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      -- vim.fn.jobstart { 'open', url } -- Mac OS
      vim.fn.jobstart { 'xdg-open', url } -- linux
    end,
  },
}
