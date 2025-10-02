local M = {}

M.config = function(lp, opts)
  table.insert(opts.sources.default, 1, "lazydev")
  table.insert(opts.sources.default, 1, "copilot")
  opts.sources.providers = {
    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      score_offset = 100,
    },
    copilot = {
      name = "copilot",
      module = "blink-cmp-copilot",
      score_offset = 100,
      async = true,
    },
  }
  require("blink-cmp").setup(opts)
end

return M
