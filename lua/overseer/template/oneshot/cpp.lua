return {
  name = "g++ build (std)",
  builder = function(params)
    local file = vim.fn.expand "%:p"
    return {
      cmd = { "g++" },
      args = { "-g", "-O2", "-std=" .. params.std, file, "-o", file .. ".out" },
      components = { { "on_output_quickfix", open = true }, "on_result_diagnostics", "default" },
    }
  end,
  params = {
    std = {
      type = "enum",
      choices = { "c++11", "c++14", "c++17", "c++20", "c++23" },
    },
  },
  condition = {
    filetype = { "cpp" },
  },
}
