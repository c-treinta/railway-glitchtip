RAILWAY_PROJECT ?= templates-test
SECRET_KEY ?= $(shell openssl rand -hex 48)

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --database redis
	railway add --service glitchtip-web
	railway add --service glitchtip-worker
	cd web && railway up --service glitchtip-web
	cd worker && railway up --service glitchtip-worker
	railway variable set --service glitchtip-web \
	  SECRET_KEY="$(SECRET_KEY)" \
	  'DATABASE_URL=${{Postgres.DATABASE_URL}}' \
	  'REDIS_URL=${{Redis.REDIS_URL}}' \
	  EMAIL_URL=consolemail://
	railway variable set --service glitchtip-worker \
	  SECRET_KEY="$(SECRET_KEY)" \
	  'DATABASE_URL=${{Postgres.DATABASE_URL}}' \
	  'REDIS_URL=${{Redis.REDIS_URL}}' \
	  EMAIL_URL=consolemail://

destroy:
	@echo "Delete services via Railway dashboard: glitchtip-web, glitchtip-worker, Postgres, Redis"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service glitchtip-web --lines 100

.PHONY: deploy destroy status logs
