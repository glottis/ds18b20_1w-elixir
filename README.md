# Ds18b20_1w

**This is a simple library for reading 1wire ds18b20 sensors**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ds18b20_1w` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ds18b20_1w, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ds18b20_1w](https://hexdocs.pm/ds18b20_1w).

## Usage 

read_sensors/0 for getting readings for any connected sensors

list_sensors/0 lists any connected sensors

