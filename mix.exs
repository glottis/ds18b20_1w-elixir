defmodule Ds18b201w.MixProject do
  use Mix.Project

  def project do
    [
      app: :ds18b20_1w,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/glottis/ds18b20_1w-elixir",
      description: "simple library for reading 1wire ds18b20 sensors",
      package: package(),
      deps: deps()
    ]
  end

  defp package() do
    [
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/glottis/ds18b20_1w-elixir"},
      name: "ds18b20_1w"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
