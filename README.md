# Deploy and Host GlitchTip on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/TEMPLATE_ID)

GlitchTip is an open-source error tracking platform and Sentry-compatible alternative. It aggregates application errors, performance issues, and uptime alerts into a single self-hosted dashboard, giving you full control over your error data without vendor lock-in.

## About Hosting GlitchTip

Hosting GlitchTip on Railway involves running two services from the same Docker image: a web service that handles the Django application, API, and Celery Beat scheduler, and a worker service that processes background tasks via Celery. Both services share a PostgreSQL database (for persistent error storage) and a Redis instance (as the message broker and cache). Railway manages Postgres and Redis as platform-provided services, so you only need to configure and deploy the two GlitchTip services. Environment variables are wired automatically between services using Railway reference variables.

## Common Use Cases

- Self-hosted error tracking for web and mobile applications with Sentry SDK compatibility
- Uptime monitoring and alerting for production services
- Privacy-first error aggregation where data must not leave your own infrastructure

## Dependencies for GlitchTip Hosting

- PostgreSQL — primary database for projects, events, and user data
- Redis — Celery message broker and result backend

### Deployment Dependencies

- Docker image: [glitchtip/glitchtip on Docker Hub](https://hub.docker.com/r/glitchtip/glitchtip)
- GlitchTip documentation: [https://glitchtip.com/documentation](https://glitchtip.com/documentation)
- GlitchTip source: [https://gitlab.com/glitchtip](https://gitlab.com/glitchtip)

### Implementation Details

Both `web` and `worker` services use the same `glitchtip/glitchtip:latest` image. The web service runs `./bin/run-all-in-one.sh` (web server + Celery Beat). The worker service runs `./bin/run-celery.sh` (Celery worker only). After first deploy, create a superuser via:

```bash
railway run --service glitchtip-web python manage.py createsuperuser
```

## Why Deploy GlitchTip on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying GlitchTip on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
