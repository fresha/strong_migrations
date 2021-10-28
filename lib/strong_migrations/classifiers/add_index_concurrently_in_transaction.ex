defmodule StrongMigrations.Classifiers.AddIndexConcurrentlyInTransaction do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{create_index_concurrently: true, disable_ddl_transaction: false}) do
    {:error, :add_index_concurrently_in_transaction}
  end

  def classify(%{create_index_concurrently: true, disable_migration_lock: false}) do
    {:error, :add_index_concurrently_in_transaction}
  end

  def classify(_migration), do: :ok
end
