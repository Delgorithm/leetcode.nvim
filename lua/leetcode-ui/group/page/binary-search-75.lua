local cmd = require("leetcode.command")

local Title = require("leetcode-ui.lines.title")
local Button = require("leetcode-ui.lines.button.menu")
local BackButton = require("leetcode-ui.lines.button.menu.back")
local Buttons = require("leetcode-ui.group.buttons.menu")
local Page = require("leetcode-ui.group.page")

local footer = require("leetcode-ui.lines.footer")
local header = require("leetcode-ui.lines.menu-header")

local page = Page()

page:insert(header)

page:insert(Title({ "Topics" }, "Binary Search"))

local list = Button("List", {
  icon = "",
  sc = "p",
  on_press = cmd.binary_search_75
})

local random = Button("Random", {
  icon = "",
  sc = "r",
  on_press = cmd.random_binary_search_75,
})

local back = BackButton("topics")

page:insert(Buttons({
  list,
  random,
  back,
}))

page:insert(footer)

return page
