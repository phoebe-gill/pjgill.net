+++
title = "Recovering the message from a failed git commit"
date = "2019-07-23"
tags = ["software"]
+++

At work, I sometimes fail to create git commits. For example:

```
$ git commit
error: gpg failed to sign the data
fatal: failed to write commit object
```

Despite appearances, your carefully crafted commit message has not been lost. You can find it in the `.git` folder in the root of the repository:

```
$ cat .git/COMMIT_EDITMSG
Recovering failing git commit message
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#	new file:   content/post/git-commit-message.md
#
```

You can then copy the message and run the commit again:

```
$ git commit -m "Recovering failing git commit message"
[master 9be38ac] Recovering failing git commit message
 1 file changed, 37 insertions(+)
 create mode 100644 content/post/git-commit-message.md
```
