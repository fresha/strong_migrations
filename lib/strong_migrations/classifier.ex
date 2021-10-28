defmodule StrongMigrations.Classifier do
  @moduledoc """
  Identifies an interface of the Classifier
  """

  alias StrongMigrations.Migration

  @callback classify(Migration.t()) :: :ok | {:error, atom()}
end
