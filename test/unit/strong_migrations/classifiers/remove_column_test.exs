defmodule StrongMigrations.Classifiers.RemoveColumnTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Classifiers.RemoveColumn
  alias StrongMigrations.Migration

  test "it has failed when trying to remove a column" do
    migration = %{Migration.new("test.exs") | remove_column: true}

    assert {:error, :remove_column_is_not_safety_assured} == RemoveColumn.classify(migration)
  end

  test "it has passed when not remove a column" do
    migration = %{Migration.new("test.exs") | remove_column: false}

    assert :ok == RemoveColumn.classify(migration)
  end
end
