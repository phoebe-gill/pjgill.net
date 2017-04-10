+++
title = "My .gitconfig"
description = "Reading the git-config docs help"
date = "2017-04-10"
+++

```
[user]
    email = ...
    name = ...
    signingkey = ...
[push]
    default = simple
[alias]
    # Aliases for laziness - fewer characters
    cmt = commit
    co = checkout
    mrg = merge
    # Often, the last log is the only relevant one.
    last = log -1 HEAD
    # More condensed and prettier than plain log.
    lg = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ci)%C(reset) %C(white)%s%C(reset) %C(dim red)- %an%C(reset)%C(bold yellow)%d%C(reset)'
    # Removes excessive verbiage from status, but not too much.
    st = status -bs
    # Useful shortcut for backing out a botched merge.
    unstage = reset HEAD --
[core]
    editor = vim
# Ensure that all commits(/merges/etc.) are GPG signed.
[commit]
    gpgSign = true
[push]
    gpgSign = true
[tag]
    forceSignAnnotated = true
```
