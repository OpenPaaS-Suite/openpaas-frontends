ARG NODE_VERSION=12.19
ARG NGINX_VERSION=1.19.3
ARG APP_GRID_ITEMS="[{ \"name\": \"Calendar\", \"url\": \"/calendar/\" }, { \"name\": \"Contacts\", \"url\": \"/contacts/\" }, { \"name\": \"Inbox\", \"url\": \"/inbox/\" }]"

FROM node:${NODE_VERSION} AS build-inbox
ARG INBOX_GIT_TREEISH=main
ARG APP_GRID_ITEMS
ARG INBOX_BASE_HREF=/inbox/
ARG BASE_HREF=${INBOX_BASE_HREF}
WORKDIR /app/esn-frontend-inbox
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-inbox/archive/${INBOX_GIT_TREEISH}.tar.gz \
                | tar -v -C /app/esn-frontend-inbox -xz --strip-components=1
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-mailto
ARG MAILTO_GIT_TREEISH=main
ARG APP_GRID_ITEMS
ARG MAILTO_BASE_HREF=/mailto/
ARG BASE_HREF=${MAILTO_BASE_HREF}
WORKDIR /app/esn-frontend-mailto
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-mailto/archive/${MAILTO_GIT_TREEISH}.tar.gz \
                | tar -v -C /app/esn-frontend-mailto -xz --strip-components=1
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-account
ARG ACCOUNT_GIT_TREEISH=main
ARG APP_GRID_ITEMS
ARG ACCOUNT_BASE_HREF=/account/
ARG BASE_HREF=${ACCOUNT_BASE_HREF}
WORKDIR /app/esn-frontend-account
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-account/archive/${ACCOUNT_GIT_TREEISH}.tar.gz \
                | tar -v -C /app/esn-frontend-account -xz --strip-components=1
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-contacts
ARG CONTACTS_GIT_TREEISH=main
ARG APP_GRID_ITEMS
ARG CONTACTS_BASE_HREF=/contacts/
ARG BASE_HREF=${CONTACTS_BASE_HREF}
WORKDIR /app/esn-frontend-contacts
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-contacts/archive/${CONTACTS_GIT_TREEISH}.tar.gz \
                | tar -v -C /app/esn-frontend-contacts -xz --strip-components=1
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-calendar
ARG CALENDAR_GIT_TREEISH=main
ARG APP_GRID_ITEMS
ARG CALENDAR_BASE_HREF=/calendar/
ARG BASE_HREF=${CALENDAR_BASE_HREF}
WORKDIR /app/esn-frontend-calendar
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-calendar/archive/${CALENDAR_GIT_TREEISH}.tar.gz \
                | tar -v -C /app/esn-frontend-calendar -xz --strip-components=1
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-calendar-public
ARG CALENDAR_PUB_GIT_TREEISH=main
ARG APP_GRID_ITEMS
ARG CALENDAR_PUB_BASE_HREF=/excal/
ARG BASE_HREF=${CALENDAR_PUB_BASE_HREF}
WORKDIR /app/esn-frontend-calendar-public
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-calendar-public/archive/${CALENDAR_PUB_GIT_TREEISH}.tar.gz \
                | tar -v -C /app/esn-frontend-calendar-public -xz --strip-components=1
RUN npm install && npm run build:prod

FROM node:${NODE_VERSION} AS build-admin
ARG ADMIN_GIT_TREEISH=main
ARG APP_GRID_ITEMS
ARG ADMIN_BASE_HREF=/admin/
ARG BASE_HREF=${ADMIN_BASE_HREF}
WORKDIR /app/esn-frontend-admin
RUN curl -sSL https://github.com/OpenPaaS-Suite/esn-frontend-admin/archive/${ADMIN_GIT_TREEISH}.tar.gz \
                | tar -v -C /app/esn-frontend-admin -xz --strip-components=1
RUN  npm install && npm run build:prod

FROM nginx:${NGINX_VERSION}
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build-inbox /app/esn-frontend-inbox/dist /var/www/inbox
COPY --from=build-mailto /app/esn-frontend-mailto/dist /var/www/mailto
COPY --from=build-account /app/esn-frontend-account/dist /var/www/account
COPY --from=build-contacts /app/esn-frontend-contacts/dist /var/www/contacts
COPY --from=build-calendar /app/esn-frontend-calendar/dist /var/www/calendar
COPY --from=build-calendar-public /app/esn-frontend-calendar-public/dist /var/www/calendar-public
COPY --from=build-admin /app/esn-frontend-admin/dist /var/www/admin
