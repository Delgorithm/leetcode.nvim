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

page:insert(Title({ "Blind 75" }, "Topics"))

local arrays_and_hashing = Button("Arrays & Hashing", {
  icon = "",
  sc = "a",
  on_press = function()
    cmd.set_menu_page("arrays-and-hashing-75")
  end,
  expandable = true,
})

local two_pointers = Button("Two Pointers", {
  icon = "",
  sc = "t",
  on_press = function()
    cmd.set_menu_page("two-pointers-75")
  end,
  expandable = true,
})

local sliding_window = Button("Sliding Window", {
  icon = "",
  sc = "w",
  on_press = function()
    cmd.set_menu_page("sliding-window-75")
  end,
  expandable = true,
})

local stack = Button("Stack", {
  icon = "",
  sc = "s",
  on_press = function()
    cmd.set_menu_page("stack-75")
  end,
  expandable = true,
})

local binary_search = Button("Binary Search", {
  icon = "",
  sc = "b",
  on_press = function()
    cmd.set_menu_page("binary-search-75")
  end,
  expandable = true,
})

local linked_list = Button("Linked List", {
  icon = "",
  sc = "u",
  on_press = function()
    cmd.set_menu_page("linked-list-75")
  end,
  expandable = true,
})

local trees = Button("Trees", {
  icon = "",
  sc = "i",
  on_press = function()
    cmd.set_menu_page("trees-75")
  end,
  expandable = true,
})

local heap_and_priority_queue = Button("Heap & Priority Queue", {
  icon = "",
  sc = "z",
  on_press = function()
    cmd.set_menu_page("heap-and-priority-queue-75")
  end,
  expandable = true,
})

local backtracking = Button("Backtracking", {
  icon = "",
  sc = "x",
  on_press = function()
    cmd.set_menu_page("backtracking-75")
  end,
  expandable = true,
})

local tries = Button("Tries", {
  icon = "",
  sc = "y",
  on_press = function()
    cmd.set_menu_page("tries-75")
  end,
  expandable = true,
})

local graph = Button("Graph", {
  icon = "",
  sc = "g",
  on_press = function()
    cmd.set_menu_page("graphs-75")
  end,
  expandable = true,
})

local dynamic_programming = Button("Dynamic Programming", {
  icon = "",
  sc = "p",
  on_press = function()
    cmd.set_menu_page("dynamic-programming-75")
  end,
  expandable = true,
})

local greedy = Button("Greedy", {
  icon = "",
  sc = "e",
  on_press = function()
    cmd.set_menu_page("greedy-75")
  end,
  expandable = true,
})

local intervals = Button("Intervals", {
  icon = "",
  sc = "v",
  on_press = function()
    cmd.set_menu_page("interval-75")
  end,
  expandable = true,
})

local math_and_geometry = Button("Math & Geometry", {
  icon = "",
  sc = "o",
  on_press = function()
    cmd.set_menu_page("math-and-geometry-75")
  end,
  expandable = true,
})

local bit_manipulation = Button("Bit Manipulation", {
  icon = "",
  sc = "m",
  on_press = function()
    cmd.set_menu_page("bit-manipulation-75")
  end,
  expandable = true,
})

local back = BackButton("blind-75")

page:insert(Buttons({
  arrays_and_hashing,
  two_pointers,
  sliding_window,
  stack,
  binary_search,
  linked_list,
  trees,
  heap_and_priority_queue,
  backtracking,
  tries,
  graph,
  dynamic_programming,
  greedy,
  intervals,
  math_and_geometry,
  bit_manipulation,
  back,
}))

page:insert(footer)

return page
