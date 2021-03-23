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

Get set up:

```
git clone git@github.com:interflux-electronics/CDN.git
cd CDN
nvm install
yarn install
```

Download all missing files from the production CDN down to `public/`:

```
bin/download
```

Serve all files in `public/` locally (for development):

```
yarn serve
open http://localhost:9000
```

Upload a file to the CDN and create its record in the production database:

```
bin/upload [file] [CDN path]
bin/upload foo.pdf documents/guides/
```

Scan for PNGs and convert them to into JPGs and WEBPs, each in 14 sizes:

```
bin/convert
```

### Questions?

Ask maintainer Jan Werkhoven:  
<a href="mailto:j.werkhoven@interflux.com">j.werkhoven@interflux.com</a>  
<a href="https://github.com/janwerkhoven">github.com/janwerkhoven</a>

---

**Interflux**  
Chemistry + Metallurgy + Electronics  
<a href="https://www.interflux.com">www.interflux.com</a>
<a href="https://lmpa.interflux.com">lmpa.interflux.com</a>
