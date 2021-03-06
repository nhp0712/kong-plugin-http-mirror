---
--- Created by liuxiaodong (v0)
--- Modified by lgazo (v1), nhp0712 (v2)
--- DateTime: 2019/4/4 9:16
---

local _M = {}
local http_client = require "kong.plugins.kong-plugin-http-mirror.http_client"
_M.read_body_on = true
_M.read_body_off = false
function _M.serialize(conf)
    local read_body = conf.mirror_request_body == _M.read_body_on
    local request = {
        method = ngx.req.get_method(),
        headers = ngx.req.get_headers(),
        query = ngx.req.get_uri_args(),
        path = ngx.var.uri
    }
    if read_body then
        request.body = ngx.req.get_body_data()
    end
    return request
end

function _M.do_mirror(premature, conf, request)
    for _, endpoint in pairs(conf.mirror_endpoints) do
        http_client.execute(endpoint, request.path, request.method, request.headers, request.query, request.body)
    end
end

return _M