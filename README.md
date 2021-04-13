# Interflux CDN

### What

This repository holds all the tools necessary to interact with the Interflux CDN.

On the CDN we store all **images**, **videos**, **PDFs** served on our multiple websites and email signatures. This CDN helps us seperate concerns. Our rapidly changing Ember (Javascript) front end apps and Rails (Ruby) back needn't be concerned with these highly cacheable static resources.

### Highlights

We use:

- Digital Ocean's S3-like CDN.
- `s3cmd` commands to interact with the CDN.
- `cwebp` commands for converting WEBPs.
- `convert` commands for converting PNGs and JPGs.
- Gulp task runner for serving on localhost:9000.

### Commands

Set up repo:

```
git clone git@github.com:interflux-electronics/CDN.git
cd CDN
nvm install
yarn install
```

Install and configure `s3cmd` for interacting with the CDN:

```
brew install s3cmd
s3cmd --configure
```

The sync files DOWN from the CDN to `public/`:

```
bin/sync-down.sh
```

To sync file UP from `public/` to CDN:

```
bin/sync-up.sh
```

IMPORTANT: Syncing treats either your local or the CDN as source-of-truth and deletes all files that are not found in the source of truth. Syncing up to the CDN from an empty `public/` folder would literally wipe the entire CDN :fire:.

Serve all files in `public/` locally (for development):

```
yarn serve
open http://localhost:9000
```

Scan for PNGs and convert them to into JPGs and WEBPs, each in 14 sizes:

```
bin/convert.sh
```

### Need help?

Ask maintainer Jan Werkhoven:  
<a href="mailto:j.werkhoven@interflux.com">j.werkhoven@interflux.com</a> 

---

### Interflux  
Chemistry + Metallurgy + Electronics  
<a href="https://www.interflux.com">www.interflux.com</a>  
<a href="https://lmpa.interflux.com">lmpa.interflux.com</a>
