-- folder structure
--
--.
--├── init.lua
--├── lazy-lock.json
--└── lua
--    ├── core
--    │   ├── config
--    │   │   ├── commands.lua
--    │   │   └── options.lua
--    │   ├── init.lua
--    │   └── plugins
--    │       ├── catppuccin.lua
--    │       ├── lspconfig.lua
--    │       ├── mason.lua
--    │       └── treesitter.lua
--    └── plugin_manager.lua
--
--5 directories, 10 files

-- the lazy nvim plugin manager
require("plugin_manager")
-- Load options from options.lua
require("config")
