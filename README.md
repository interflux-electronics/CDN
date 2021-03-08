# Interflux CDN

### What

The Interflux Content Delivery Network (CDN) is responsible for making Interflux
images, videos, fonts and PDFs available at lowest possible latency, no matter
where you are in the world.

In this repository we prepare all the files that need to uploaded to the CDN.

For example:

1.  All JPG need to be converted to WEBP
2.  Email templates and CSS need to be pre-processed
3.  Files are fingerprinted to bust caches

### Tech stack

We levarage:

- Digital Ocean as CDN
- Gulp as task runners
- Node for scraping web content
- Shell scripts for automation
- `cwebp` for converting WEBP images

### Setup

```
git clone git@github.com:interflux-electronics/cdn.interflux.com.git
cd cdn.interflux.com
nvm install
yarn install
yarn serve
```

### Questions?

Ask maintainer Jan Werkhoven:  
<a href="mailto:j.werkhoven@interflux.com">j.werkhoven@interflux.com</a>  
<a href="https://github.com/janwerkhoven">github.com/janwerkhoven</a>

---

**Interflux**  
Chemistry + Metallurgy + Electronics  
<a href="mailto:ask@interflux.com">ask@interflux.com</a>  
<a href="https://interflux.com">interflux.com</a>
