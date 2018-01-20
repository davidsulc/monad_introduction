# Monads in Elixir

A short talk for the Zürich Erlang/Elixir meetup, given on 17.01.18.

The presentation can be seen at [https://davidsulc.github.io/monad_introduction/](https://davidsulc.github.io/monad_introduction/). When viewing the presentation, you can press 's' to view speaker notes. Slides are grouped by theme, so going to the next slide will be achieved by either pressing the "down" (to "drill down" in the theme) or "right" (to go to the next theme) arrow keys. Look to the bottom right to see what navigation options you have.

The example code is available at [https://github.com/davidsulc/monad_introduction/](https://github.com/davidsulc/monad_introduction/). To follow along, follow the git commits:

1. first, a simple "happy path" is developed
1. additional "error" paths are added to the code, which either makes the code less readable using the `with` construct, or adds additional pattern matching cases to keep the pipeline in place resulting in e.g. non-sensical `sanitize_extension(nil)` patterns.
1. code is refactored using the Maybe monad (also called the Option monad)
1. tests are added to the Maybe monad to verify the monad laws are respected
