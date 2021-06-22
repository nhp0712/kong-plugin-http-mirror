---
--- Created by liuxiaodong.
--- DateTime: 2019/4/3 19:10
---
return {
    no_consumer = true, -- this plugin will only be API-wide,
    fields = {
        mirror_request_body = {
            type = "string",
            enum = { "on", "off" },
            default = "off", required = true,
        },
        mirror_endpoints = {
            type = "array",
            item_schema = {
                fields = {
                    url = { type = "string", required = true }
                }
            }
        }

    },
}