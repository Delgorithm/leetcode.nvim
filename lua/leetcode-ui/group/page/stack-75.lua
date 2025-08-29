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

page:insert(Title({ "Topics" }, "Stack"))

local list = Button("List", {
  icon = "",
  sc = "p",
  on_press = cmd.stack_75
})

local back = BackButton("topics-75")

page:insert(Buttons({
  list,
  back,
}))

page:insert(footer)

return page
