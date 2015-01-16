local config = require("lapis.config")

config("development", {
    port = 8080,
    lua_code_cache = "off",
})

config("production", {
    port = 80,
    num_workers = 4,
    lua_code_cache = "on",
})

