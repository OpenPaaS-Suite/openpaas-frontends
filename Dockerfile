ARG NGINX_VERSION=1.19.3
ARG INBOX_DOCKER_TAG=linagora/esn-frontend-inbox:branch-main
ARG MAILTO_DOCKER_TAG=linagora/esn-frontend-mailto:branch-main
ARG ACCOUNT_DOCKER_TAG=linagora/esn-frontend-account:branch-main
ARG CONTACTS_DOCKER_TAG=linagora/esn-frontend-contacts:branch-main
ARG CALENDAR_DOCKER_TAG=linagora/esn-frontend-calendar:branch-main
ARG CALENDAR_PUBLIC_DOCKER_TAG=linagora/esn-frontend-calendar-public:branch-main
ARG ADMIN_DOCKER_TAG=linagora/esn-frontend-admin:branch-main

FROM ${INBOX_DOCKER_TAG} as esn-frontend-inbox-base
FROM ${MAILTO_DOCKER_TAG} as esn-frontend-mailto-base
FROM ${ACCOUNT_DOCKER_TAG} as esn-frontend-account-base
FROM ${CONTACTS_DOCKER_TAG} as esn-frontend-contacts-base
FROM ${CALENDAR_DOCKER_TAG} as esn-frontend-calendar-base
FROM ${CALENDAR_PUBLIC_DOCKER_TAG} as esn-frontend-calendar-public-base
FROM ${ADMIN_DOCKER_TAG} as esn-frontend-admin-base

FROM nginx:${NGINX_VERSION}
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=esn-frontend-inbox-base /usr/share/nginx/html /var/www/inbox
COPY --from=esn-frontend-mailto-base /usr/share/nginx/html /var/www/mailto
COPY --from=esn-frontend-account-base /usr/share/nginx/html /var/www/account
COPY --from=esn-frontend-contacts-base /usr/share/nginx/html /var/www/contacts
COPY --from=esn-frontend-calendar-base /usr/share/nginx/html /var/www/calendar
COPY --from=esn-frontend-calendar-public-base /usr/share/nginx/html /var/www/calendar-public
COPY --from=esn-frontend-admin-base /usr/share/nginx/html /var/www/admin
