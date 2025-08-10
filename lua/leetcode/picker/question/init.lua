local config = require("leetcode.config")
local log = require("leetcode.logger")
local ui_utils = require("leetcode-ui.utils")
local utils = require("leetcode.utils")
local Question = require("leetcode-ui.question")
local Picker = require("leetcode.picker")

---@class leet.Picker.Question: leet.Picker
local P = {}

P.width = 100
P.height = 0.6

---@param items lc.cache.Question[]
---@param opts table<string, string[]>
---
---@return lc.cache.Question[]
function P.filter(items, opts)
  if vim.tbl_isempty(opts or {}) then
    return items
  end

  ---@param q lc.cache.Question
  return vim.tbl_filter(function(q)
    local diff_flag = true
    if opts.difficulty and not vim.tbl_contains(opts.difficulty, q.difficulty:lower()) then
      diff_flag = false
    end

    local status_flag = true
    if opts.status and not vim.tbl_contains(opts.status, q.status) then
      status_flag = false
    end

    return diff_flag and status_flag
  end, items)
end

---@param items lc.cache.Question[]
---@param group_by_category boolean
---@return lc.cache.Question[]
function P.group_by_category(items, group_by_category)
  if not group_by_category then
    return items
  end

  local problemlist = require("leetcode.cache.problemlist")

  local categories = {}

  for _, question in ipairs(items) do
    local full_question = question
    if not question.topic_tags or #question.topic_tags == 0 then
      full_question = problemlist.get_by_title_slug(question.title_slug) or question
    end

    local tags = full_question.topic_tags or full_question.topicTags or {}

    if #tags == 0 then
      local found = false
      for _, cat in ipairs(categories) do
        if cat.category == "Other" then
          table.insert(cat.questions, question)
          found = true
          break
        end
      end
      if not found then
        table.insert(categories, { category = "Other", questions = { question } })
      end
    else
      local main_tag = tags[1]
      local category_name = main_tag.name or main_tag.nameTranslated or tostring(main_tag)

      local found = false
      for _, cat in ipairs(categories) do
        if cat.category == category_name then
          table.insert(cat.questions, question)
          found = true
          break
        end
      end
      if not found then
        table.insert(categories, { category = category_name, questions = { question } })
      end
    end
  end

  -- Trier les catégories alphabétiquement
  table.sort(categories, function(a, b) return a.category < b.category end)

  -- Créer une liste plate avec des séparateurs
  local result = {}
  for _, cat in ipairs(categories) do
    -- Ajouter un header de catégorie
    table.insert(result, {
      frontend_id = "---",
      title = "─── " .. cat.category:upper() .. " ───",
      title_slug = "__category_" .. cat.category,
      difficulty = "",
      status = "category_header",
      ac_rate = 0,
      paid_only = false,
      is_category_header = true,
    })

    -- Ajouter les questions de cette catégorie
    for _, question in ipairs(cat.questions) do
      table.insert(result, question)
    end
  end

  return result
end

---@param content lc.cache.Question[]
---@param opts table<string, string[]>
---@param group_by_category boolean|nil
---@return { entry: any, value: lc.cache.Question }[]
function P.items(content, opts, group_by_category)
  local filtered = P.filter(content, opts)
  local grouped = P.group_by_category(filtered, group_by_category)

  return vim.tbl_map(function(item)
    return { entry = P.entry(item), value = item }
  end, grouped)
end

---@param question lc.cache.Question
local function display_user_status(question)
  if question.paid_only then
    return config.auth.is_premium and config.icons.hl.unlock or config.icons.hl.lock
  end

  return config.icons.hl.status[question.status] or { " " }
end

---@param question lc.cache.Question
local function display_difficulty(question)
  local hl = ui_utils.diff_to_hl(question.difficulty)
  return { config.icons.square, hl }
end

---@param question lc.cache.Question
local function display_question(question)
  local index = { question.frontend_id .. ".", "leetcode_normal" }
  local title = { utils.translate(question.title, question.title_cn) }
  local ac_rate = { ("(%.1f%%)"):format(question.ac_rate), "leetcode_ref" }

  return unpack({ index, title, ac_rate })
end

function P.entry(item)
  if item.is_category_header then
    return {
      { "",         "leetcode_normal" },
      { "",         "leetcode_normal" },
      { item.title, "leetcode_list" },
    }
  end

  return {
    display_user_status(item),
    display_difficulty(item),
    display_question(item),
  }
end

---@param item lc.cache.Question
function P.ordinal(item)
  return ("%s. %s %s %s"):format(
    tostring(item.frontend_id),
    item.title,
    item.title_cn,
    item.title_slug
  )
end

function P.select(selection, close)
  if selection.is_category_header then
    return
  end

  if selection.paid_only and not config.auth.is_premium then
    return log.warn("Question is for premium users only")
  end
  if close then
    close()
  end
  Question(selection):mount()
end

return P
