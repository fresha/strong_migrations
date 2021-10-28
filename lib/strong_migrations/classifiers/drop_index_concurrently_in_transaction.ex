defmodule StrongMigrations.Classifiers.DropIndexConcurrentlyInTransaction do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{drop_index_concurrently: true, disable_ddl_transaction: false}) do
    {:error, :drop_index_concurrently_in_transaction}
  end

  def classify(%{drop_index_concurrently: true, disable_migration_lock: false}) do
    {:error, :drop_index_concurrently_in_transaction}
  end

  def classify(_migration), do: :ok
end
