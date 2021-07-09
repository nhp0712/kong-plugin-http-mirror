# Kong Http-Mirror Plugin


> A Kong plugin that will mirror original request to other endpoints.

## Description


This is a plugin like nginx ```mirror``` directive. It can mirror origin request to one or more endpoint.

## Configuration


```json
{
    "name": "http-mirror",
    "config": {
        "mirror_request_body": "false",
        "mirror_endpoints": [
            "http://127.0.0.1:9001"
        ]
    }
}
```

| parameter                  | type   | default | description |  
| ----------                 | ----   |  ------ | ------------|
| name                       | string |         | http-mirror |  
| config.mirror_request_body | string | false   | Indicates whether the client request body is mirrored. |  
| config.mirror_endpoints    | array  |         | endpoint |  



## Author

tarepanda1024
lgazo
nhp0712

## Liscence


MIT License

Copyright (c) 2019 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## Plugin Installation and how to integrate with Docker-Kong

1. Set up luarocks on your system:
```$ brew install luarocks```

2. Clone this repository (prefer inside ./docker-kong/customize/):
```$ git clone https://github.com/nhp0712/kong-plugin-http-mirror.git && cd kong-plugin-http-mirror```

3. Build and pack plugin:
```
$ luarocks make
$ luarocks pack kong-plugin-http-mirror 1.0.0-0
$ luarocks install kong-plugin-http-mirror-1.0.0-0.all.rock 
```

4. Create rocksdir folder:
```
$ cd ..
$ cp kong-plugin-http-mirror-1.0.0-0.all.rock rocksdir
```
5. In ./docker-kong/customize, build docker image by executing:
```
$ docker build \
   --build-arg "KONG_LICENSE_DATA=$KONG_LICENSE_DATA" \
   --build-arg KONG_BASE="kong:latest" \
   --build-arg PLUGINS="kong-plugin-http-mirror" \
   --build-arg ROCKS_DIR="./rocksdir" \
   --tag "kong-traffic" .
```
6. Redirect to ./docker-kong/compose, execute:
```
$ docker-compose up
```
7. Enable and add configuration by using Konga/KongKonnect (preferably) or curl command:
```
$ curl -X POST http://127.0.0.1:8001/plugins/   --data "name=kong-plugin-http-mirror"   --data "config.mirror_request_body=false"   --data "config.mirror_endpoints=http://1.23.456.789:8088"
```
=> Then now any call to http://127.0.0.1:8000/<any-api> will also mirror a call of http://1.23.456.789:8088/<any-api>
    

(This plugin is tested working with kong:latest (2.4.1-alpine), and it currently doesn’t support load balancing for multiple mirror endpoints directly. Thus, a possible solution is to configure a single mirror endpoint that points to another API gateway server (nginx/kong/...), then configure upstream on that API gateway for load balancing purposes).

