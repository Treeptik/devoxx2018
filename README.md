# Create a Jenkins User

```
groupadd -g 1000 jenkins
useradd -g jenkins jenkins
```

# Build the Jenkins image

```
docker build --build-arg GID=1000 -t treeptik/jenkins jenkins
```

# LifeCycle

We provide a *startup.sh* to run the complete Stack

