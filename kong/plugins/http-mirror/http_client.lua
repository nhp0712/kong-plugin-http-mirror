--
-- Creator: liuxiaodong
-- Modified by lgazo (v1), nhp0712 (v2)
-- DateTime: 2019/4/3 20:10
-- Http Client

local _M = { }
local http = require("resty.http")

function _M.execute(url, path, method, headers, query, body)

    local httpc = http.new()

    local scheme, host, port = unpack(httpc:parse_uri(url))

    --connect_timeout, send_timeout, read_timeout
    httpc:set_timeouts(5000, 10000, 10000)

    httpc:connect(host, port)

    -- res:status,reason,headers,has_body,body_reader,read_body,read_trailers
    local res, err = httpc:request({
        path = path,
        method = method,
        query = query,
        body = body,
        headers = headers
    })

    if not res then
        ngx.log(ngx.ERR, "request:", url, " call failed. err=", err)
        return nil
    end

    -- max_idle_timeout(ms), pool_size(each worker)
    httpc:set_keepalive()
end

return _M