ARG NODE_VERSION=12.19
ARG NGINX_VERSION=1.19.3
ARG INBOX_GIT_TREEISH=main
ARG MAILTO_GIT_TREEISH=main
ARG ACCOUNT_GIT_TREEISH=main
ARG CONTACTS_GIT_TREEISH=main
ARG CALENDAR_GIT_TREEISH=main
ARG CALENDAR_PUB_GIT_TREEISH=main
ARG ADMIN_GIT_TREEISH=main
ARG APP_GRID_ITEMS="[{ \"name\": \"Calendar\", \"url\": \"/calendar/\" }, { \"name\": \"Contacts\", \"url\": \"/contacts/\" }, { \"name\": \"Inbox\", \"url\": \"/inbox/\" }]"

FROM node:${NODE_VERSION} AS build-inbox
ARG INBOX_GIT_TREEISH
WORKDIR /app/esn-frontend-inbox-${INBOX_GIT_TREEISH}
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-inbox/archive/${INBOX_GIT_TREEISH}.tar.gz \
                | tar -v -C /app -xz
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-mailto
ARG MAILTO_GIT_TREEISH
WORKDIR /app/esn-frontend-mailto-${MAILTO_GIT_TREEISH}
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-mailto/archive/${MAILTO_GIT_TREEISH}.tar.gz \
                | tar -v -C /app -xz
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-account
ARG ACCOUNT_GIT_TREEISH
WORKDIR /app/esn-frontend-account-${ACCOUNT_GIT_TREEISH}
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-account/archive/${ACCOUNT_GIT_TREEISH}.tar.gz \
                | tar -v -C /app -xz
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-contacts
ARG CONTACTS_GIT_TREEISH
WORKDIR /app/esn-frontend-contacts-${CONTACTS_GIT_TREEISH}
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-contacts/archive/${CONTACTS_GIT_TREEISH}.tar.gz \
                | tar -v -C /app -xz
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-calendar
ARG CALENDAR_GIT_TREEISH
WORKDIR /app/esn-frontend-calendar-${CALENDAR_GIT_TREEISH}
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-calendar/archive/${CALENDAR_GIT_TREEISH}.tar.gz \
                | tar -v -C /app -xz
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-calendar-public
ARG CALENDAR_PUB_GIT_TREEISH
WORKDIR /app/esn-frontend-calendar-public-${CALENDAR_PUB_GIT_TREEISH}
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-calendar-public/archive/${CALENDAR_PUB_GIT_TREEISH}.tar.gz \
                | tar -v -C /app -xz
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-admin
ARG ADMIN_GIT_TREEISH
WORKDIR /app/esn-frontend-admin-${ADMIN_GIT_TREEISH}
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-admin/archive/${ADMIN_GIT_TREEISH}.tar.gz \
                | tar -v -C /app -xz
RUN  npm install && npm run build:prod

FROM nginx:${NGINX_VERSION}
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/conf.d/default.conf
ARG INBOX_GIT_TREEISH
COPY --from=build-inbox /app/esn-frontend-inbox-${INBOX_GIT_TREEISH}/dist /var/www/inbox
ARG MAILTO_GIT_TREEISH
COPY --from=build-mailto /app/esn-frontend-mailto-${MAILTO_GIT_TREEISH}/dist /var/www/mailto
ARG ACCOUNT_GIT_TREEISH
COPY --from=build-account /app/esn-frontend-account-${ACCOUNT_GIT_TREEISH}/dist /var/www/account
ARG CONTACTS_GIT_TREEISH
COPY --from=build-contacts /app/esn-frontend-contacts-${CONTACTS_GIT_TREEISH}/dist /var/www/contacts
ARG CALENDAR_GIT_TREEISH
COPY --from=build-calendar /app/esn-frontend-calendar-${CALENDAR_GIT_TREEISH}/dist /var/www/calendar
ARG CALENDAR_PUB_GIT_TREEISH
COPY --from=build-calendar-public /app/esn-frontend-calendar-public-${CALENDAR_PUB_GIT_TREEISH}/dist /var/www/calendar-public
ARG ADMIN_GIT_TREEISH
COPY --from=build-admin /app/esn-frontend-admin-${ADMIN_GIT_TREEISH}/dist /var/www/admin
