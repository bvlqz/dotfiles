return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    icons = {
      mappings = false,
      keys = {
        Up = "UP ",
        Down = "DOWN ",
        Left = "LEFT ",
        Right = "RIGHT ",
        C = "C ",
        M = "M ",
        D = "D ",
        S = "S ",
        CR = "CR ",
        Esc = "ESC ",
        ScrollWheelDown = "ScrollWheelDown ",
        ScrollWheelUp = "ScrollWheelUp ",
        NL = "NL ",
        BS = "BS ",
        Space = "SPACE ",
        Tab = "TAB ",
        F1 = "F1",
        F2 = "F2",
        F3 = "F3",
        F4 = "F4",
        F5 = "F5",
        F6 = "F6",
        F7 = "F7",
        F8 = "F8",
        F9 = "F9",
        F10 = "F10",
        F11 = "F11",
        F12 = "F12",
      }
    },
  },
  show_icons = false,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
