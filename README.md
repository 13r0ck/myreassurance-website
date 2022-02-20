requires cloudflare workers to host.

How to publish first time:
1. `wrangler login`
2. `wrangler secret put STRIPE_API_KEY`
then enter the api key given from stripe
3. wrangler publish

How to publish updates:
1. wrangler publish

This currently doesn't include the frontend, that must be copied
from the `main` branch
1. `git checkout main`
2. `npm install`
3. npm run-script build
4. copy ./dist* into `git checkout workers` ./public/*
