defmodule StrongMigrations.Classifiers.AddIndexConcurrentlyInTransactionTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Classifiers.AddIndexConcurrentlyInTransaction
  alias StrongMigrations.Migration

  test "it has failed when creating an index concurrently with disabled ddl transaction" do
    migration = %{
      Migration.new("test.exs")
      | create_index_concurrently: true,
        disable_migration_lock: true
    }

    assert {:error, :add_index_concurrently_in_transaction} ==
             AddIndexConcurrentlyInTransaction.classify(migration)
  end

  test "it has failed when creating an index concurrently with disabled migration lock" do
    migration = %{
      Migration.new("test.exs")
      | create_index_concurrently: true,
        disable_ddl_transaction: true
    }

    assert {:error, :add_index_concurrently_in_transaction} ==
             AddIndexConcurrentlyInTransaction.classify(migration)
  end

  test "it has passed when creating an index concurrently with enabled ddl and migration lock" do
    migration = %{
      Migration.new("test.exs")
      | create_index_concurrently: true,
        disable_ddl_transaction: true,
        disable_migration_lock: true
    }

    assert :ok == AddIndexConcurrentlyInTransaction.classify(migration)
  end
end
