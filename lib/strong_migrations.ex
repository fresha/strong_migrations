defmodule StrongMigrations do
  @moduledoc """
  Documentation for `StrongMigrations`.
  """

  alias StrongMigrations.Loader
  alias StrongMigrations.Parser
  alias StrongMigrations.ReasonsTranslator
  alias StrongMigrations.Validator

  @type migration_path() :: String.t()
  @type migration_file() :: String.t()
  @type validation_result() :: {migration_file(), [atom()]}
  @type reason() :: String.t()

  @doc """
  Starts analyze of the application's migrations.

  ## Examples

      iex> StrongMigrations.analyze()
      :safe

  """
  @spec analyze([migration_path()]) :: :safe | {:unsafe, [StrongMigrations.reason()]}
  def analyze(migration_paths \\ []) do
    migration_paths
    |> Loader.load()
    |> Parser.parse()
    |> Validator.validate()
    |> ReasonsTranslator.translate()
  end

  defmacro safety_assured(do: expression) do
    quote do
      unquote(expression)
    end
  end
end
