defmodule StrongMigrations do
  @moduledoc """
  Documentation for `StrongMigrations`.
  """

  alias StrongMigrations.Loader
  alias StrongMigrations.Parser
  alias StrongMigrations.Validator

  @type migration_path() :: String.t()
  @type migration_file() :: String.t()

  @doc """
  Starts analyze of the application's migrations.

  ## Examples

      iex> StrongMigrations.analyze()
      :safe

  """
  @spec analyze([migration_path()]) :: :safe | :unsafe
  def analyze(migration_paths \\ []) do
    migration_paths
    |> Loader.load()
    |> Parser.parse()
    |> Validator.validate()

    :safe
  end
end
