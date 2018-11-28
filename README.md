# phpMemAdmin in a Docker Container

This is a Docker container to run phpMemAdmin (https://github.com/clickalicious/phpmemadmin)
aginst a memcached container / server.

You'll need to know your memcached hostname / ip and the port (default port is 11211 for memcached).

## Run it:
```
docker run -it -p 8080:8080 -e MEMADMIN_USERNAME='memUser' -e MEMADMIN_PASSWORD='memPassword' -e MEMCACHED_HOST='memcached.hostname.or.ip' -e MEMCACHED_PORT='memcached.port' vesica/memadmin:latest
```

Head over to http://localhost:8080, enter the username and password you passed above, and see what you're caching.

## Build it (and then run it):
```
docker build . -t vesica/memadmin  
```

## Publish Image

This image is already built by Docker Hub when the master branch of this repository is updated.
It is published at vesica/memadmin (https://hub.docker.com/r/vesica/memadmin/).

