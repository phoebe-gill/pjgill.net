+++
title = "HTTPS Everywhere! Now including here"
description = "This website now redirects HTTP → HTTPS"
draft = false
date = "2017-12-19"
tags = []
+++

Shortly after initially creating this website just over a year ago, I discovered the setting that my hosting provider provides to turn on HTTPS access.

I've now finally worked out how to redirect HTTP → HTTPS. Some helpful docs from the [SRCF](https://www.srcf.net/faq/blogging) gave me the necessary configuration settings. This is something I've wanted to do for some time, as it seems a little pointless having an HTTPS site without making sure that all visitors get to enjoy a secure connection.

Needless to say, this is all rather hacky. I _think_ it works by rewriting incoming HTTP requests to be HTTPS requests instead. There's probably a way to get round this - I think I'd need to add `SSLRequireSSL` to ensure that evading my URL re-writing would only get you to an error page. I can only assume that my hosting provider is doing something clever however, as adding `SSLRequireSSL` to my config immediately brought this site down (c.f. the SRCF, which was perfectly happy...).

I've got long-term plans for this site. I'd like to move to a hosting provider that doesn't force me to use a password for SSH. I'd also like to do something about the four cookies that Privacy Badger is currently blocking for me. In the very long term, I might even consider turning on HSTS to force HTTPS connections. That would be the sensible replacement for this rather dubious hack - though with a much higher risk of danger in the event of misconfiguration.

For future reference, I now have the following in `.htaccess`:

```
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI} [R=permanent]
```