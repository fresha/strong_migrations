defmodule StrongMigrations.Classifiers.RenameColumnTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Classifiers.RenameColumn
  alias StrongMigrations.Migration

  test "it has failed when trying to rename a column" do
    migration = %{Migration.new("test.exs") | rename_column: true}

    assert {:error, :rename_column_is_not_safe} == RenameColumn.classify(migration)
  end

  test "it has passed when trying to rename a column, but it's safety assured" do
    migration = %{
      Migration.new("test.exs")
      | rename_column: true,
        safety_assured: [:rename_column]
    }

    assert :ok == RenameColumn.classify(migration)
  end

  test "it has passed when not removing a column" do
    migration = %{Migration.new("test.exs") | rename_column: false}

    assert :ok == RenameColumn.classify(migration)
  end
end
