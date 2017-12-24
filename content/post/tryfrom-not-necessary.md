+++
title = "TryFrom is not really necessary"
date = "2016-11-28"
tags = ["software"]
+++

Not when we can do:

```rust
pub struct Alpha {
    beta: Option<bool>,
}

impl From<Alpha> for Option<bool> {
    fn from(a: Alpha) -> Option<bool> {
        a.beta
    }
}
```
