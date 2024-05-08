defmodule Whatlangex.MixProject do
  use Mix.Project

  @description "Whatlang NIF bindings"
  @source_url "https://github.com/pierrelegall/whatlangex"
  @version "0.3.0"

  def project do
    [
      app: :whatlangex,
      deps: [
        {:rustler, "~> 0.30", optional: true},
        {:rustler_precompiled, "~> 0.7"},
        {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
      ],
      description: @description,
      elixir: "~> 1.14",
      homepage_url: @source_url,
      package: [
        maintainers: ["Pierre Le Gall"],
        name: "Whatlangex",
        licenses: ["MIT"],
        links: %{"GitHub" => @source_url},
        files: [
          "LICENSE",
          "README.md",
          "lib",
          "native/whatlang_nif/.cargo",
          "native/whatlang_nif/src",
          "native/whatlang_nif/Cargo*",
          "checksum-*.exs",
          "mix.exs"
        ]
      ],
      source_url: @source_url,
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
