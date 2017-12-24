+++
title = "Some useful git aliases"
date = "2017-03-15"
tags = ["software"]
+++

EDIT (2017-04-10): I've now posted my [~/.gitconfig](https://gist.github.com/bjgill/6b440841c4fdb3fec056f45cc50038dc)

Compiled from various sources, this is what I use on a day-to-day basis.

Removes excessive verbiage from `status`, but not too much.
```
alias.st=status -bs
```

Some things are too long to type.
```
alias.co=checkout
```

Often, the last log is the only relevant one.
```
alias.last=log -1 HEAD
```

More condensed and prettier than plain `log`.
```
alias.lg=log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ci)%C(reset) %C(white)%s%C(reset) %C(dim red)- %an%C(reset)%C(bold yellow)%d%C(reset)'
```

Using these shortcuts saves typing and ensures that I don't forget to [sign my commits](https://mikegerwitz.com/papers/git-horror-story).
```
alias.cmt=commit -S
alias.mrg=merge -S
```

Useful shortcut for backing out a botched merge.
```
alias.unstage=reset HEAD --
```
