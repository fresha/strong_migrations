defmodule StrongMigrations.MixProject do
  use Mix.Project

  @source_url "https://github.com/patrykwozinski/strong_migrations"
  @version "0.1.0"

  def project do
    [
      app: :strong_migrations,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      dialyzer: [
        plt_add_deps: :apps_direct,
        plt_add_apps: [:mix],
        plt_ignore_apps: [:logger]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.25.5", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        # "HOW_TO_RELEASE.md": [title: "How to Release"],
        # "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@source_url}/commits/master",
        "GitHub" => @source_url
      }
    ]
  end
end
