local config = require("lapis.config")

config("development", {
    port = 8081,
    lua_code_cache = "on",
    worker_connections = 1024
})

config("production", {
    port = 8080,
    num_workers = 4,
    lua_code_cache = "off",
    worker_connections = 1024
})

