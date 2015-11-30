defmodule Geo2d.Mixfile do
  use Mix.Project

  def project do
    [
      app: :geo_2d_convex_hull,
      version: "0.0.1",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      { :geo_2d_types, github: "ttvd/elixir-geo-2d-convex-hull"}
    ]
  end

  def package do
    [
      files: ["lib", "mix.exs", "README.md"],
      contributors: ["Mykola Konyk"],
      licenses: ["MS-RL"],
      links: %{"GitHub" => "https://github.com/ttvd/elixir-geo-2d-convex-hull"}
    ]
  end
end
