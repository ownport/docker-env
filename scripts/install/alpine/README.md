# Alpine installation scripts

## runit usage

### Example of configuration

```sh
mkdir -p /etc/service/privoxy/ && \
printf "#!/bin/sh\nset -e\nexec /usr/sbin/privoxy --no-daemon /etc/privoxy/config" > /etc/service/privoxy/run && \
chmod +x /etc/service/privoxy/run
```
