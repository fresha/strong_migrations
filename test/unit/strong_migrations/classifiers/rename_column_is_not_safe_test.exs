defmodule StrongMigrations.Classifiers.RenameColumnIsNotSafeTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Classifiers.RenameColumnIsNotSafe
  alias StrongMigrations.Migration

  test "it has failed when trying to rename a column" do
    migration = %{Migration.new("test.exs") | rename_column: true}

    assert {:error, :rename_column_is_not_safe} == RenameColumnIsNotSafe.classify(migration)
  end

  test "it has passed when not removing a column" do
    migration = %{Migration.new("test.exs") | rename_column: false}

    assert :ok == RenameColumnIsNotSafe.classify(migration)
  end
end
