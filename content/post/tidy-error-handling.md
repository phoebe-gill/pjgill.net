+++
title = "Tidy error handling"
description = "The joys of Result and Option"
draft = false
date = "2016-11-28"

+++

In some code I was looking through recently, I came across the following
pattern:

{{< highlight rust >}}
match a.do_something() {
    Ok(b) => {
        match b.do_something_else() {
            Ok(_) => Ok(()),
            Err(err) => CustomError::from(err),
        }
    }
    Err(err) => CustomError::from(err),
}
{{< /highlight >}}

It is very clear what that code is doing, and what all the possible paths are.
However, there are ways of shortening this and reducing the level of indentation
required. We could, for example, use `try!(...)` (or `...?` in 1.13):

{{< highlight rust >}}
let mut b = try!(a.do_something());

try!(b.do_something_else());

Ok(())
{{< /highlight >}}

However, this has certain drawbacks. This would fall apart if we wanted to do
anything clever with the errors (e.g. write an error log before returning). I'm
also not particularly fond of `try!` - it implicitly introduces a bunch of
`return` calls into the code.

Instead, the pattern I've come to prefer is as follows:

{{< highlight rust >}}
a.do_something()
    .and_then(|b| b.do_something_else())
    .map(|_| ())
    .map_err(CustomError::from)
{{< /highlight >}}

This has the advantage of conciseness, with each quantum of functionality on a
separate line.

[`std::option::Option`](https://doc.rust-lang.org/std/option/enum.Option.html)
and 
[`std::result::Result`](https://doc.rust-lang.org/std/result/enum.Result.html)
are two very powerful elements of Rust, both with a number of very useful
methods. I'd thoroughly recommend reading their docs - I've been referring to
both quite a bit lately, and think it has helped the readability of the code
I've written.
