# openpaas-front

Repository that contains recipes to build & publish OpenPaaS frontends :
* Inbox
* Mailto
* Account
* Contacts
* Calendar
* Calendar Public
* Admin

Every frontends is built separately and added in Docker image to be served by Nginx.

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

| Build Arg      | Description | Default Value |
| ----------- | ----------- | ----------- |
| NODE_VERSION             | NodeJS version | 12.19 |
| NGINX_VERSION            | Nginx version | 1.19.3 |
| INBOX_GIT_TREEISH        | Git treeish name for inbox frontend | main |
| MAILTO_GIT_TREEISH       | Git treeish name for mailto frontend | main |
| ACCOUNT_GIT_TREEISH      | Git treeish name for account frontend | main |
| CONTACTS_GIT_TREEISH     | Git treeish name for contacts frontend | main |
| CALENDAR_GIT_TREEISH     | Git treeish name for calendar frontend | main |
| CALENDAR_PUB_GIT_TREEISH | Git treeish name for public calendar frontend | main |
| CALENDAR_PUB_GIT_TREEISH | Git treeish name for public calendar frontend | main |
| ADMIN_GIT_TREEISH        | Git treeish name for admin frontend | main |
| INBOX_BASE_HREF          | Inbox frontend base href | /inbox/ |
| MAILTO_BASE_HREF         | Mailto frontend base href | /mailto/ |
| ACCOUNT_BASE_HREF        | Account frontend base href | /account/ |
| CONTACTS_BASE_HREF       | Contacts frontend base href | /contacts/ |
| CALENDAR_BASE_HREF       | Calendar frontend base href | /calendar/ |
| CALENDAR_PUB_BASE_HREF   | Calendar Public frontend base href | /excal/ |
| ADMIN_BASE_HREF          | Admin frontend base href | /admin/ |
| APP_GRID_ITEMS           | Grid frontends urls  | [{ \"name\": \"Calendar\", \"url\": \"/calendar/\" }, { \"name\": \"Contacts\", \"url\": \"/contacts/\" }, { \"name\": \"Inbox\", \"url\": \"/inbox/\" }] |

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
