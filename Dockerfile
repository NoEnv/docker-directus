FROM directus/directus:9.26.0 AS builder

FROM node:18-alpine AS runtime

USER node

WORKDIR /directus

EXPOSE 8055

ENV \
	DB_CLIENT="sqlite3" \
	DB_FILENAME="/directus/database/database.sqlite" \
	EXTENSIONS_PATH="/directus/extensions" \
	STORAGE_LOCAL_ROOT="/directus/uploads" \
	NODE_ENV="production" \
	NPM_CONFIG_UPDATE_NOTIFIER="false"

COPY --from=builder --chown=node:node /directus/dist .

CMD : \
	&& node /directus/cli.js bootstrap \
	&& node /directus/cli.js start \
	;
