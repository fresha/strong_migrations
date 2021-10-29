defmodule StrongMigrations.ParserTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Migration
  alias StrongMigrations.Parser

  test "parsing empty file means nothing should be found" do
    file_path = fixtures("empty.exs")

    assert [Migration.new(file_path)] ==
             Parser.parse([
               file_path
             ])
  end

  describe ":disable_ddl_transaction seeking" do
    test "should find :disable_ddl_transaction option when enabled" do
      [migration] =
        Parser.parse([
          fixtures("disable_ddl_transaction_true.exs")
        ])

      assert migration.disable_ddl_transaction == true
    end

    test "should not find :disable_ddl_transaction option when disabled" do
      [migration] =
        Parser.parse([
          fixtures("disable_ddl_transaction_false.exs")
        ])

      assert migration.disable_ddl_transaction == false
    end
  end

  describe ":disable_migration_lock seeking" do
    test "should find :disable_migration_lock option when enabled" do
      [migration] =
        Parser.parse([
          fixtures("disable_migration_lock_true.exs")
        ])

      assert migration.disable_migration_lock == true
    end

    test "should not find :disable_migration_lock option when disabled" do
      [migration] =
        Parser.parse([
          fixtures("disable_migration_lock_false.exs")
        ])

      assert migration.disable_migration_lock == false
    end
  end

  test "should find :create_index option" do
    [migration] =
      Parser.parse([
        fixtures("create_index.exs")
      ])

    assert migration.create_index == true
  end

  test "should find :create_index_concurrently option" do
    [migration] =
      Parser.parse([
        fixtures("create_index_concurrently.exs")
      ])

    assert migration.create_index_concurrently == true
  end

  test "should find :drop_index option" do
    [migration] =
      Parser.parse([
        fixtures("drop_index.exs")
      ])

    assert migration.drop_index == true
  end

  test "should find :drop_index_concurrently option" do
    [migration] =
      Parser.parse([
        fixtures("drop_index_concurrently.exs")
      ])

    assert migration.drop_index_concurrently == true
  end

  test "should find :rename_column option" do
    [migration] =
      Parser.parse([
        fixtures("rename_column.exs")
      ])

    assert migration.rename_column == true
  end

  test "should find :rename_column option when two columns to change" do
    [migration] =
      Parser.parse([
        fixtures("rename_two_columns.exs")
      ])

    assert migration.rename_column == true
  end

  test "should find :remove_column option" do
    [migration] =
      Parser.parse([
        fixtures("remove_column.exs")
      ])

    assert migration.remove_column == true
  end

  test "should find :remove_column for _if_exists option " do
    [migration] =
      Parser.parse([
        fixtures("remove_column_if_exists.exs")
      ])

    assert migration.remove_column == true
  end

  test "should find :remove_column option when two columns to change" do
    [migration] =
      Parser.parse([
        fixtures("remove_two_columns.exs")
      ])

    assert migration.remove_column == true
  end

  test "should find :remove_column option for _if_exists when two columns to change" do
    [migration] =
      Parser.parse([
        fixtures("remove_two_columns_if_exists.exs")
      ])

    assert migration.remove_column == true
  end

  defp fixtures(migration) do
    "test/fixtures/parser/#{migration}"
  end
end
