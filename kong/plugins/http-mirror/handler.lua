---
--- Created by liuxiaodong.
--- DateTime: 2019/4/3 19:10
---
local mirror = require "kong.plugins.http-mirror.mirror"
local BasePlugin = require "kong.plugins.base_plugin"

local HttpMirrorHandler = BasePlugin:extend()

HttpMirrorHandler.PRIORITY = 1

function HttpMirrorHandler:new()
    HttpMirrorHandler.super.new(self, "http-mirror")
end

function HttpMirrorHandler:access(conf)
    HttpMirrorHandler.super.log(self)
    if conf.mirror_request_body == "on" then
        ngx.req.read_body()
    end
end

function HttpMirrorHandler:log(conf)
    HttpMirrorHandler.super.log(self)
    local request = mirror.serialize(conf)
    local ok, err = ngx.timer.at(0, mirror.do_mirror, conf, request)
    if not ok then
        ngx.log(ngx.ERR, "mirror plugin failed to create timer: ", err)
    end

end

return HttpMirrorHandler