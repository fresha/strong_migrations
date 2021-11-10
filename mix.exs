defmodule StrongMigrations.MixProject do
  use Mix.Project

  @source_url "https://github.com/patrykwozinski/strong_migrations"
  @version "0.1.4"

  def project do
    [
      app: :strong_migrations,
      description: "Catch unsafe migrations in your Elixir application",
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        plt_add_deps: :apps_direct,
        plt_add_apps: [:mix]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/test_doubles"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger, :typed_struct]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.25.5", only: :dev, runtime: false},
      {:typed_struct, "~> 0.1"}
    ]
  end

  defp docs do
    [
      extras: [
        "HOW_TO_RELEASE.md": [title: "How to Release"],
        "LICENSE.md": [title: "License"],
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
