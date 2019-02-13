+++
title = "Why I use Firefox beta"
draft = false
date = "2019-02-12"
+++

The other day, our frontend integration tests were broken on my machine. These tests use Selenium, a tool for testing web pages using Firefox. It turned out that Firefox was waiting to install updates, and this broke Selenium.

Upon relalising what was happening, one of my colleagues asked me why I was using Firefox. The rest of the team uses Chrome. This, then, is my answer.

I initially switched to Firefox at the release of Firefox Quantum - the first version of Firefox to contain code written in the Rust programming language. At the time, I was working primarily in Rust. So I wanted to see for myself what the first major use of Rust in the real world looked like.

More interesting, however, was my choice of the beta release channel. Beta is an early release of Firefox - 6 weeks ahead of the 'normal' version. This meant that I would get new features early (a welcome one being U2F support). It also meant that I would get 6 weeks advanced warning of changes that would break websites.

This came in handy last year, [when Firefox stopped trusting certificates issued by Symantec](https://blog.mozilla.org/security/2018/03/12/distrust-symantec-tls-certificates/). I noticed this when a few websites stopped working for me - two internal, and one external. I notified the people responsible for each of these services. By the time the distrust changes landed in the 'normal' version of Firefox, all three services had been fixed. As a result, users of those services did not notice any difference.

So that's why I use Firefox beta - to give me and those who run the services I use advance warning of breaking changes. I would highly recommend that at least one person in your organisation do so as well.
