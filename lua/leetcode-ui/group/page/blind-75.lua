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

page:insert(Title({ "Problems" }, "Blind 75"))

local list = Button("List", {
  icon = "",
  sc = "p",
  on_press = cmd.blind_75
})

local random = Button("Random", {
  icon = "",
  sc = "r",
  on_press = cmd.random_blind_75,
})

local topics = Button("Topics", {
  icon = "",
  sc = "t",
  on_press = function()
    cmd.set_menu_page("topics-75")
  end,
  expandable = true,
})


local back = BackButton("problems")

page:insert(Buttons({
  list,
  random,
  topics,
  back,
}))

page:insert(footer)

return page
