defmodule StrongMigrations.Classifiers.AddIndexNotConcurrentlyTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Classifiers.AddIndexNotConcurrently
  alias StrongMigrations.Migration

  test "it has failed when creating an index not concurrently" do
    migration = %{Migration.new("test.exs") | create_index: true}

    assert {:error, :add_index_not_concurrently} == AddIndexNotConcurrently.classify(migration)
  end

  test "it has passed when creating an index not concurrently but it's safety assured" do
    migration = %{Migration.new("test.exs") | create_index: true, safety_assured: [:create_index]}

    assert :ok == AddIndexNotConcurrently.classify(migration)
  end

  test "it has passed when not creating an index" do
    migration = %{Migration.new("test.exs") | create_index: false}

    assert :ok == AddIndexNotConcurrently.classify(migration)
  end
end
