# Glitchtip

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/c-treinta/railway-glitchtip)

Open-source error tracking (Sentry alternative).

**Services:** `glitchtip-web`, `glitchtip-worker`, `Postgres`, `Redis` (Railway-managed)

## Deploy

```bash
make deploy
# SECRET_KEY is auto-generated
```

## Post-Deploy

Create superuser:
```bash
railway run --service glitchtip-web python manage.py createsuperuser
```

## Environment Variables (auto-wired)

| Variable | Services |
|----------|----------|
| `SECRET_KEY` | web, worker |
| `DATABASE_URL` | web, worker |
| `REDIS_URL` | web, worker |
| `EMAIL_URL` | web, worker (console output by default) |
