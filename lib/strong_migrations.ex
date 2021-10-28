defmodule StrongMigrations do
  @moduledoc """
  Documentation for `StrongMigrations`.
  """

  alias StrongMigrations.MigrationsLoader

  @type migration_path() :: String.t()

  @doc """
  Starts analyze of the application's migrations.

  ## Examples

      iex> StrongMigrations.analyze()
      :safe

  """
  @spec analyze([migration_path()]) :: :safe | :unsafe
  def analyze(migration_paths \\ []) do
    MigrationsLoader.load(migration_paths)

    :safe
  end
end
