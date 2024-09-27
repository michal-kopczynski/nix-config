-- ChatGpt plugin
return {
  'robitx/gp.nvim',
  config = function()
    local config = {
      -- Please start with minimal config possible.
      -- Just openai_api_key if you don't have OPENAI_API_KEY env set up.
      -- Defaults change over time to improve things, options might get deprecated.
      -- It's better to change only things where the default doesn't fit your needs.

      -- required openai api key (string or table with command and arguments)
      openai_api_key = { 'cat', '/home/michal/.oa' },
      -- openai_api_key = { "cat", "path_to/openai_api_key" },
      -- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
      -- openai_api_key: "sk-...",
      -- openai_api_key = os.getenv("env_name.."),
      -- openai_api_key = os.getenv 'OPENAI_API_KEY',
    }
    require('gp').setup(config)

    -- or setup with your own config (see Install > Configuration in Readme)
    -- require("gp").setup(config)
    -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
  end,
}
