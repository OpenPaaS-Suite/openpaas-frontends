# openpaas-front

Repository that contains recipes to build & publish OpenPaaS frontends :
* Inbox
* Mailto
* Account
* Contacts
* Calendar
* Calendar Public
* Admin

Every frontends will be builded separately and available in a single Docker image and served by Nginx. 

Nginx locations can be find in `nginx.conf` file

## Build

Build all frontends on the main branch

```sh
docker build -t openpaas-front .
```

### Custom Build

You can override standard build using docker build arguments

#### Available build arguments

---------------------------------------

| Build Arg      | Description |
| ----------- | ----------- |
| NODE_VERSION   | NodeJS version        |
| NGINX_VERSION   | Nginx version        |
| INBOX_GIT_BRANCH   | Git branch name for inbox frontend        |
| MAILTO_GIT_BRANCH   | Git branch name for mailto frontend        |
| ACCOUNT_GIT_BRANCH   | Git branch name for account frontend        |
| CONTACTS_GIT_BRANCH   | Git branch name for contacts frontend        |
| CALENDAR_GIT_BRANCH   | Git branch name for calendar frontend        |
| CALENDAR_PUB_GIT_BRANCH   | Git branch name for public calendar frontend        |
| ADMIN_GIT_BRANCH   | Git branch name for admin frontend        |

---------------------------------------

Build frontends on the main branch and contact frontend on a custom branch `hantt12-patch-1`

```sh
docker build --build-arg CONTACTS_GIT_BRANCH=hantt12-patch-1 -t openpaas-front .
```

Build all frontends and overrides nginx version to `1.18.0`
```sh
docker build --build-arg NGINX_VERSION=1.18.0 -t openpaas-front .
```

#### Extra option

`--no-cache`: rebuild all frontends disabling local cache

# Run the image

Start docker image and map local port `8080` to the nginx container port 
```sh
docker run -d --name openpaas-front -p 8080:80 openpaas-front
```

# Check container static assets

When image is running, you are able to check container assets
```sh
docker exec -ti openpaas-front ls /var/www
```
