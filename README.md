# [MyREassurance.com](https://myreassurance.com/)

:construction_worker: the webpage isn't quite done yet.

## How to publish
The server code is in the `workers` branch. Run `npm run-script build` here
then copy `./dist/*` into `./public` in the `workers` branch.
Publishing instructions to cloudflare workers is in the `workers` README.md
branch.

## Run locally
using `npm start`

The biggest hidden feature of this project is the design flexibiity. The best example of this is the website theme. Edit the `priamaryColor` (~ Line 280 )variable to anything you would like (supports all tailwind colors) and run locally.

![demo](https://github.com/13r0ck/myreassurance-website/blob/main/public/img/demo.gif?raw=true)
