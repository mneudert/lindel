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
  [
    # ...
    {:lindel, "~> 0.1"}
    # ...
  ]
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
  url: "http://url.to.elasticsearch.host"
```

This creates a wrapper structure with the following namespace mappings:

- `Elastix.Index` - `MyIndex`
- `Elastix.Search` - `MyIndex`
- `Elastix.Document` - `MyIndex.Document`
- `Elastix.Mapping` - `MyIndex.Mapping`

All functions asking for both server url and index name are provided without
both parameters:

```elixir
# original functions
Elastix.Index.exists?(elastic_url, index_name)
Elastix.Search.search(elastic_url, index_name, types, data)

Elastix.Document.index(elastic_url, index_name, type_name, id, data)
Elastix.Mapping.put(elastic_url, index_name, type_name, data)

# wrapped functions
MyIndex.exists?()
MyIndex.search(types, data)

MyIndex.Document.index(type_name, id, data)
MyIndex.Mapping.put(type_name, data)
```

## License

This work is free. Matching `:elastix` you can redistribute it and/or modify it
under the terms of the `Do What The Fuck You Want To Public License, Version 2`,
as published by Sam Hocevar. See [http://www.wtfpl.net/](http://www.wtfpl.net/)
for more details.
