{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraLuaConfig = ''
      -- Tabs
      vim.opt.expandtab = true                -- Use spaces instead of tabs
      vim.opt.shiftwidth = 2                  -- Size of an indent
      vim.opt.tabstop = 2                     -- Number of spaces tabs count for
      vim.opt.smartindent = true              -- Insert indents automatically

      -- Search
      vim.opt.smartcase = true                -- Do not ignore case with capitals
      vim.opt.ignorecase = true

      -- UI
      vim.opt.mouse = "a"
      vim.opt.termguicolors = true
      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.list = true                     -- Show some invisible characters

      vim.opt.joinspaces = false              -- No double spaces with join
      vim.opt.hidden = true                   -- Enable background buffers

      -- Keep selection while indenting
      vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
    '';
  };
}
