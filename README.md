# Lindel

This library is a small wrapper around
[`:elastix`](https://hex.pm/packages/elastix) to simplify interaction with
a "static" index.

__Experimental stuff, may change unexpectedly!__

Due to the nature of being a wrapper it may cease functioning with any random
update of the `:elastix` module. So be sure to test whatever you are using...


## Setup

Add Lindel as a dependency to your `mix.exs` file:

```elixir
defp deps do
  [{ :lindel, "~> 0.1" }]
end
```

You should also update your applications to include all necessary projects:

```elixir
def application do
  # :elastix is not started by :lindel itself!
  [ applications: [ :elastix, :lindel ]]
end
```


## Usage

Usage depends on two parts, `configuration` and `index definition`.

Defining the index is as simple as just creating a module for it:

```elixir
defmodule MyIndex do
  use Lindel.Index, otp_app: :my_otp_app
end
```

The configuration is done separately:

```elixir
config :my_otp_app, MyIndex,
  name: "the_name_of_the_index"
  url:  "http://url.to.elasticsearch.host"
```

If done properly you have the following wrappers defined for you:

- `MyIndex.Document` == `Elastix.Document`
- `MyIndex.Index` == `Elastix.Index`
- `MyIndex.Mapping` == `Elastix.Mapping`
- `MyIndex.Search` == `Elastix.Search`

Most of methods of the original `:elastix` modules are provided while not
requiring you to pass an index name or server url anymore.


## License

This work is free. Matching `:elastix` you can redistribute it and/or modify it
under the terms of the `Do What The Fuck You Want To Public License, Version 2`,
as published by Sam Hocevar. See [http://www.wtfpl.net/](http://www.wtfpl.net/)
for more details.
