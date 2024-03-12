# Jenkins Project

## Build Jenkins Docker Image && Container:

### 1.
Build the Docker Image && Container

```
docker-compose up -d
```

## Notes

- The Jenkins user is created with a basic password, to change it:

Line 9
```
vim jenkins_build/Dockerfile
```

- Current Admin username and password is admin, change the credentials by editing this file

Line 39
```
vim jenkins_build/Dockerfile
```

## Build Jenkins Docker Image && Container again with --build flag
```
docker-compose up -d --build
```
