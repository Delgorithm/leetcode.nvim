local utils = require("leetcode.api.utils")
local queries = require("leetcode.api.queries")
local config = require("leetcode.config")
local urls = require("leetcode.api.urls")
local Spinner = require("leetcode.logger.spinner")

---@class lc.ProblemsApi
local Problems = {}

---@param cb? function
---@param noti? boolean
---
---@return lc.cache.Question[], lc.err
function Problems.all(cb, noti)
  local endpoint = urls.problems:format("algorithms")

  local spinner
  if noti then
    spinner = Spinner:start("updating problemlist cache", "points")
  end

  if cb then
    utils.get(endpoint, {
      callback = function(res, err)
        if err then
          if spinner then
            spinner:error(err.msg)
          end
          return cb(nil, err)
        end

        local problems = utils.normalize_problems(res.stat_status_pairs)

        if config.is_cn then
          if spinner then
            spinner:update("fetching title translations")
          end
          Problems.translated_titles(function(titles, terr)
            if terr then
              if spinner then
                spinner:error(terr.msg)
              end
              return cb(nil, terr)
            end

            problems = utils.translate_titles(problems, titles)
            if spinner then
              spinner:success("cache updated")
            end

            cb(problems)
          end)
        else
          if spinner then
            spinner:success("cache updated")
          end

          cb(problems)
        end
      end,
    })
  else
    local res, err = utils.get(endpoint)
    if err then
      if spinner then
        spinner:error(err.msg)
      end
      return nil, err
    end

    local problems = utils.normalize_problems(res.stat_status_pairs)

    if config.is_cn then
      local titles, terr = Problems.translated_titles()
      if terr then
        if spinner then
          spinner:error(terr.msg)
        end
        return nil, terr
      end

      if spinner then
        spinner:success("problems cache updated")
      end
      return utils.translate_titles(problems, titles)
    else
      if spinner then
        spinner:success("problems cache updated")
      end
      return problems
    end
  end
end

function Problems.question_of_today(cb)
  local query = queries.qot

  utils.query(query, {}, {
    callback = function(res, err)
      if err then
        return cb(nil, err)
      end

      local tday_record = res.data["todayRecord"]
      local question = config.is_cn and tday_record[1].question or tday_record.question
      cb(question)
    end,
  })
end

function Problems.translated_titles(cb)
  local query = queries.translations

  if cb then
    utils.query(query, {}, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
        cb(res.data.translations)
      end,
    })
  else
    local res, err = utils.query(query, {})
    if err then
      return nil, err
    end
    return res.data.translations
  end
end

function Problems.blind_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "oizxjoit",
    skip = 0,
    limit = 75,
    version = "v2"
  }, {
    callback = function(res, err)
      if err then
        return cb(nil, err)
      end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    end
  })
end

function Problems.arrays_and_hashing_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8s07vm",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.two_pointers_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx84p1or",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.sliding_window_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx84i46i",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.stack_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx815j4j",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.binary_search_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx81ve75",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.linked_list_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx816hjh",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.trees_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8yuo3s",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.heap_and_priority_queue_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8cshgg",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.backtracking_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8cbiid",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.tries_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8bp89e",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.graph_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8b7gkm",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.dynamic_programming_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8jtexi",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.greedy_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8f4ce5",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.interval_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx8ffwyg",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.math_and_geometry_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx3hvpv2",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.bit_manipulation_75(cb)
  local query = queries.problem_list_detail
  utils.query(query, {
    favoriteSlug = "vx3huuxr",
    skip = 0,
    limit = 7,
    version = "v2"
  }, {
      callback = function(res, err)
        if err then
          return cb(nil, err)
        end
      local title_slugs = {}
      if res.data["favoriteQuestionList"] and res.data["favoriteQuestionList"]["questions"] then
        for _, q in ipairs(res.data["favoriteQuestionList"]["questions"]) do
          table.insert(title_slugs, q.titleSlug)
        end
      end
      return cb(title_slugs)
    })
end

function Problems.top_interview_150(cb)
  local query = queries.study_plan_detail

  utils.query(query, { slug = "top-interview-150" }, {
    callback = function(res, err)
      if err then
        return cb(nil, err)
      end
      local title_slugs = {}
      for _, v in ipairs(res.data["studyPlanV2Detail"]["planSubGroups"]) do
        for _, q in ipairs(v["questions"]) do
          table.insert(title_slugs, q.title_slug)
        end
      end
      return cb(title_slugs)
    end
  })
end

function Problems.leetcode_75(cb)
  local query = queries.study_plan_detail

  utils.query(query, { slug = "leetcode-75" }, {
    callback = function(res, err)
      if err then
        return cb(nil, err)
      end
      local title_slugs = {}
      for _, v in ipairs(res.data["studyPlanV2Detail"]["planSubGroups"]) do
        for _, q in ipairs(v["questions"]) do
          table.insert(title_slugs, q.title_slug)
        end
      end
      return cb(title_slugs)
    end
  })
end

return Problems
