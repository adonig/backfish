defmodule Backfish.MixProject do
  use Mix.Project

  def project do
    [
      app: :backfish,
      description: "A flexible and powerful backtracking library for Elixir.",
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      # ExDoc
      name: "Backfish",
      source_url: "https://github.com/adonig/backfish",
      homepage_url: "https://github.com/adonig/backfish",
      docs: [
        main: "Backfish",
        logo: "logo.png",
        extras: ["LICENSE", "README.md"]
      ]
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
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      name: :backfish,
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/adonig/backfish"},
      maintainers: ["Andreas Donig"]
    ]
  end
end
