defmodule StrongMigrations do
  @moduledoc """
  Documentation for `StrongMigrations`.
  """

  @doc """
  Starts analyze of the application's migrations.

  ## Examples

      iex> StrongMigrations.analyze()
      :safe

  """
  @spec analyze() :: :safe | :unsafe
  def analyze do
    :safe
  end
end
