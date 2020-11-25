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

## Standard Build

Build all frontends on the main branch

```sh
# Using BuildKit
DOCKER_BUILDKIT=1 docker build --pull -t openpaas-front . --no-cache
```

You can override standard build using docker build arguments.

### Available build arguments

---------------------------------------

| Build Arg      | Description | Default Value |
| ----------- | ----------- | ----------- |
| NGINX_VERSION            | Nginx version | 1.19.3 |
| INBOX_DOCKER_TAG        | Docker image for inbox frontend | linagora/esn-frontend-inbox:branch-main |
| MAILTO_DOCKER_TAG       | Docker image for mailto frontend | linagora/esn-frontend-mailto:branch-main |
| ACCOUNT_DOCKER_TAG      | Docker image for account frontend | linagora/esn-frontend-account:branch-main |
| CONTACTS_DOCKER_TAG     | Docker image for contacts frontend | linagora/esn-frontend-contacts:branch-main |
| CALENDAR_DOCKER_TAG     | Docker image for calendar frontend | linagora/esn-frontend-calendar:branch-main |
| CALENDAR_PUBLIC_DOCKER_TAG | Docker image for public calendar frontend | linagora/esn-frontend-calendar-public:branch-main |
| ADMIN_DOCKER_TAG        | Docker image for admin frontend | linagora/esn-frontend-admin:branch-main |

---------------------------------------

Build frontends on the `main-branch` tag and contacts frontend on a specific tag `2.0.0`

```sh
# Using BuildKit
DOCKER_BUILDKIT=1 docker build --pull --build-arg CONTACTS_DOCKER_TAG=linagora/esn-frontend-contacts:2.0.0 -t openpaas-front . --no-cache
```

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

## Custom builds

Build all frontends on the main branch

```sh
# Using BuildKit
DOCKER_BUILDKIT=1 docker build --pull -f Dockerfile.custom -t openpaas-front-custom . --no-cache
```

You can override standard build using docker build arguments.

### Available build arguments

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
# Using BuildKit
DOCKER_BUILDKIT=1 docker build --pull -f Dockerfile.custom --build-arg CONTACTS_GIT_TREEISH=hantt12-patch-1 -t openpaas-front-custom . --no-cache
```

Build all frontends and overrides nginx version to `1.18.0`

```sh
# Using BuildKit
DOCKER_BUILDKIT=1 docker build --pull -f Dockerfile.custom --build-arg NGINX_VERSION=1.18.0 -t openpaas-front-custom . --no-cache
```

#### Extra option

`--no-cache`: rebuild all frontends disabling local cache

# Run the image

Start docker image and map local port `8080` to the nginx container port
```sh
docker run -d --name openpaas-front-custom -p 8080:80 openpaas-front-custom
```

# Check container static assets

When image is running, you are able to check container assets
```sh
docker exec -ti openpaas-front-custom ls /var/www
```
