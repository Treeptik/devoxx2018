# Docker Machine

```
machine create master1 --virtualbox-memory 4096
```

# Build the Jenkins image

To discover the right GID
```
machine ssh jenkinsmaster1
ls -n /var/run/docker.sock | awk '{print $4}'
```

Then,
```
docker build --build-arg GID=100 -t treeptik/jenkins jenkins
docker network create skynet
```

# LifeCycle

```
docker-compose up -d
docker-compose logs
```


# Access to Applications

Get the ip from machine with `docker-machine ip master1`
In the following example, IP will be 192.168.99.100

Open with browser at:
```
http://gitlab.192.168.99.100.xip.io
http://jenkins.192.168.99.100.xip.io
http://portainer.192.168.99.100.xip.io
```
