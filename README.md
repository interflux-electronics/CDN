# Interflux CDN

### What

This repository holds all the tools necessary to interact with the Interflux CDN. On the CDN we store all **images**, **videos**, **PDFs** served on our multiple websites and email signatures. This CDN helps us seperate concerns. Our rapidly changing Ember (Javascript) front end apps and Rails (Ruby) back needn't be concerned with these highly cacheable static resources.

### Tools

- Script for **uploading files** a file to the CDN and creating a record in the production database.
- Script for downloading all the production CDN files to your local.
- Script for converting PNGs into JPGs and WEBPs, each in 14 sizes.

### Dependencies

- Files are hosted on an S3-like CDN at Digital Ocean.
- `s3cmd` commands to interact with the CDN.
- `cwebp` commands for converting WEBPs.
- `convert` commands for converting PNGs and JPGs.
- Gulp task runner for serving on localhost:9000.

### Commands

Getting set up:

```
git clone git@github.com:interflux-electronics/CDN.git
cd CDN
nvm install
yarn install
```

Serve files locally:

```
yarn serve
open http://localhost:9000
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
