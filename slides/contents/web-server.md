# Web Server

---
##Apache Httpd

At beginning, it only handle static request. Then it use module to handle dynamic request
---
##Nginx

HTTP and reverse proxy server
---
## Unicorn
backend application server for running Rack-based Ruby applications

---
## Why Unicorn Need Nginx

Avoid slow client, push it to nginx.
---
## What can nginx do

1.buffer all HTTP request
2.be fast
3.efficiently handle slow client
4.should server static file
---
## How to setup a working website
1.buy a machine & deploy
2.buy a domain
3.find a dns server(dnspod.cn)
4.备案 only in China
---
## DNS
join.thoughtworkschina.com
0. find root server(root domain is .)
1. root server response com server(top level domain is .com)
2. com server response thoughtworkschina server(thoughtworkschina is second level domain)
3. thoughtworkschina server response 121.40.137.240(join.* is sub domain)
video https://www.youtube.com/watch?v=2ZUxoi7YNgs
---
## IP Address

121.40.137.240

| type | Max Network   | IP Address                | Address Per Network | Private IP Address          |
|------|---------------|---------------------------|---------------------|-----------------------------|
| A    | 126（2^7-2)   | 0.0.0.0-127.255.255.255   | 16,777,216 (2^24)   | 10.0.0.0-10.255.255.255     |
| B    | 16384(2^14)   | 128.0.0.0-191.255.255.255 | 65,536 (2^16)       | 172.16.0.0-172.31.255.255   |
| C    | 2097152(2^21) | 192.0.0.0-223.255.255.255 | 256 (2^8)           | 192.168.0.0-192.168.255.255 |

---
## Homework -- Linux Videos

[The Code Linux](http://v.youku.com/v_show/id_XMTI3MDQ1NjM2.html)
[Revolution OS](http://v.youku.com/v_show/id_XNjQ0ODk2Nzgw.html)
[Code Rush](http://v.youku.com/v_show/id_XNjA2NDI2MTUy.html)
鸟哥私房菜，能看多少是多少

---
