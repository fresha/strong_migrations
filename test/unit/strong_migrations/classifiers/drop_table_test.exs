defmodule StrongMigrations.Classifiers.DropTableTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Classifiers.DropTable
  alias StrongMigrations.Migration

  test "it has failed when trying to drop a table" do
    migration = %{Migration.new("test.exs") | drop_table: true}

    assert {:error, :drop_table_is_not_safety_assured} == DropTable.classify(migration)
  end

  test "it has passed when trying to drop a table, but it's safety assured" do
    migration = %{
      Migration.new("test.exs")
      | drop_table: true,
        safety_assured: [:drop_table]
    }

    assert :ok == DropTable.classify(migration)
  end

  test "it has passed when not drop a table" do
    migration = %{Migration.new("test.exs") | drop_table: false}

    assert :ok == DropTable.classify(migration)
  end
end
