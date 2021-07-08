---
--- Created by liuxiaodong.
--- DateTime: 2019/4/3 19:10
---
local typedefs = require "kong.db.schema.typedefs"

return {
    name = "http-mirror",
    fields = {
        {
            -- this plugin will only be applied to Services or Routes
            consumer = typedefs.no_consumer
        },
        { protocols = typedefs.protocols_http },
        {
            config = {
                type = "record",
                fields = {
                    -- Describe your plugin's configuration's schema here.
                    { mirror_request_body = {
                        type = "boolean",
                        default = false, required = true,
                    }, },
                    { mirror_endpoints = {
                        type = "array",
                        required = true,
                        elements = {
                            type = "string",
                        },
                    }, },
                },
            },
        },
    },
}