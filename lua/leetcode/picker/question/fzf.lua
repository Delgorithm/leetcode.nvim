local fzf = require("fzf-lua")
local problemlist = require("leetcode.cache.problemlist")
local t = require("leetcode.translator")
local question_picker = require("leetcode.picker.question")
local Picker = require("leetcode.picker")

local deli = " "

return function(questions, opts, group_by_category)
  local items = question_picker.items(questions, opts, group_by_category)

  for i, item in ipairs(items) do
    items[i] = Picker.normalize({ item })[1]
        .. deli
        .. Picker.apply_hl(item.value.title_slug, "leetcode_alt")
  end

  fzf.fzf_exec(items, {
    prompt = t("Select a Question") .. (group_by_category and " (Grouped)" or "") .. "> ",
    winopts = {
      height = question_picker.height,
      width = question_picker.width,
    },
    fzf_opts = {
      ["--delimiter"] = deli,
      ["--nth"] = "3..-3",
    },
    actions = {
      ["default"] = function(selected)
        local slug = Picker.hidden_field(selected[1], deli)
        if slug:match("^__category_") then
          return
        end
        local question = problemlist.get_by_title_slug(slug)
        question_picker.select(question)
      end,
    },
  })
end
