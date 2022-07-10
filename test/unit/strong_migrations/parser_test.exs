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

  test "should not find create index option when safety assured" do
    [migration] =
      Parser.parse([
        fixtures("safety_assured_create_index.exs")
      ])

    assert migration.create_index == false
  end

  test "should not find create index option when safety assured many" do
    [migration] =
      Parser.parse([
        fixtures("safety_assured_create_indexes.exs")
      ])

    assert migration.create_index == false
  end

  test "should not find create index option when safety assured but drop table was not assured" do
    [migration] =
      Parser.parse([
        fixtures("safety_assured_one_of_two_opts.exs")
      ])

    assert migration.drop_table == true
    assert migration.create_index == false
  end

  test "should find :create_index option" do
    [migration] =
      Parser.parse([
        fixtures("create_index.exs")
      ])

    assert migration.create_index == true
  end

  test "should find :create_index option when unique_index used" do
    [migration] =
      Parser.parse([
        fixtures("create_unique_index.exs")
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

  test "should find :create_index_concurrently option for unique_index" do
    [migration] =
      Parser.parse([
        fixtures("create_unique_index_concurrently.exs")
      ])

    assert migration.create_index_concurrently == true
  end

  test "should find :create_index_concurrently with many options" do
    [migration] =
      Parser.parse([
        fixtures("create_index_concurrently_many_options.exs")
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

  test "should find :drop_table option" do
    [migration] =
      Parser.parse([
        fixtures("drop_table.exs")
      ])

    assert migration.drop_table == true
  end

  test "should find :drop_table for _if_exists option " do
    [migration] =
      Parser.parse([
        fixtures("drop_table_if_exists.exs")
      ])

    assert migration.drop_table == true
  end

  test "should find :drop_table option when two columns to change" do
    [migration] =
      Parser.parse([
        fixtures("drop_two_tables.exs")
      ])

    assert migration.drop_table == true
  end

  test "should find :drop_table option for _if_exists when two columns to change" do
    [migration] =
      Parser.parse([
        fixtures("drop_two_tables_if_exists.exs")
      ])

    assert migration.drop_table == true
  end

  describe "mixed operations in single migration" do
    test "should find :drop_table and :remove_column in a single migration" do
      [migration] =
        Parser.parse([
          fixtures("drop_table_and_remove_column.exs")
        ])

      assert migration.drop_table == true
      assert migration.remove_column == true
    end

    test "should find :drop_table and :remove_column in a single migration with if exist" do
      [migration] =
        Parser.parse([
          fixtures("drop_table_and_remove_column_if_exist.exs")
        ])

      assert migration.drop_table == true
      assert migration.remove_column == true
    end

    test "should set :default_is_function if default is a function on change" do
      assert [%{default_is_function: true}] =
               Parser.parse([
                 fixtures("add_column_with_func_default.exs")
               ])

      assert [%{default_is_function: true}] =
               Parser.parse([
                 fixtures("add_if_not_exists_column_with_func_default.exs")
               ])

      assert [%{default_is_function: true}] =
               Parser.parse([
                 fixtures("modify_column_with_func_default.exs")
               ])

      assert [%{default_is_function: true}] =
               Parser.parse([
                 fixtures("add_column_with_sequential_default.exs")
               ])

      assert [%{default_is_function: false}] =
               Parser.parse([
                 fixtures("empty.exs")
               ])

      assert [%{default_is_function: false}] =
               Parser.parse([
                 fixtures("create_with_column_with_func_default.exs")
               ])
    end
  end

  defp fixtures(migration) do
    "test/fixtures/parser/#{migration}"
  end
end
