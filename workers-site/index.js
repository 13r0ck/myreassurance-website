import { getAssetFromKV, mapRequestToAsset } from '@cloudflare/kv-asset-handler'

/**
 * The DEBUG flag will do two things that help during development:
 * 1. we will skip caching on the edge, which makes it easier to
 *    debug.
 * 2. we will return an error message on exception in your Response rather
 *    than the default 404.html page.
 */
const DEBUG = false

const ERRORS = {
  stripeFailure: "Failed to create stripe redirect. Possible issues: Stripe API may have changed since 2022/02/20, STRIPE_API_KEY may have changed, or server may have incorrect or missing STRIPE_API_KEY"
}

addEventListener('fetch', event => {
  event.respondWith(handleEvent(event))
})

function urlHas(str, event) {
  return event.request.url.includes(str);
}

// Main logic for the cloudflare worker
async function handleEvent(event) {
  let options = {}
  // HANDLE STRIPE REQUESTS
  if (urlHas("/stripe", event)) {
    const session = await getStripeSession(event);
    if (session && session.url) {
      return Response.redirect(session.url, 303);
    } else {
      return new Response(new Blob(), { status: 500, statusText: ERRORS.stripeFailure })
    }
  // HANDLE STATIC FILES
  } else {
    try {
      if (DEBUG) {
        // customize caching
        options.cacheControl = {
          bypassCache: true,
        }
      }

      const page = await getAssetFromKV(event, options)

      // allow headers to be altered
      const response = new Response(page.body, page)

      response.headers.set('X-XSS-Protection', '1; mode=block')
      response.headers.set('X-Content-Type-Options', 'nosniff')
      response.headers.set('X-Frame-Options', 'DENY')
      response.headers.set('Referrer-Policy', 'unsafe-url')
      response.headers.set('Feature-Policy', 'none')

      return response

    } catch (e) {
      // if an error is thrown try to serve the asset at 404.html
      if (!DEBUG) {
        try {
          let notFoundResponse = await getAssetFromKV(event, {
            mapRequestToAsset: req => new Request(`${new URL(req.url).origin}/404.html`, req),
          })

          return new Response(notFoundResponse.body, { ...notFoundResponse, status: 404 })
        } catch (e) {}
      }

      return new Response(e.message || e.toString(), { status: 500 })
    }
  }
}

async function getStripeSession (event) {
  if (urlHas("setup", event)) {
    return callStripeAPI(SETUP);
  } else if (urlHas("activation", event)) {
    return callStripeAPI(ACTIVATION);
  } else {
    return
  }
}

async function callStripeAPI(product) {
  const Stripe = require("stripe");
  const stripe = Stripe(STRIPE_API_KEY, {
    // Cloudflare Workers use the Fetch API for their API requests.
    httpClient: Stripe.createFetchHttpClient()
  });
  try {
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [{
          price: product.price,
          quantity: 1
      }],
      mode: product.mode,
      success_url: product.success,
      cancel_url: product.cancel,
    });
    return session
  } catch (e) {
    console.log(JSON.stringify(e))
    return
  }
}

const SETUP = {
  price: "price_1KUyHeKApNKktyeLRN50HqQL",
  mode: "payment",
  success: "https://myreassurance.com/setup-success",
  cancel: "https://myreassurance.com"
}

const ACTIVATION = {
  price: "price_1KVpcgKApNKktyeLhUMsQ8wk",
  mode: "subscription",
  success: "https://myreassurance.com/activation-success",
  cancel: "https://myreassurance.com/activation-failed"
}