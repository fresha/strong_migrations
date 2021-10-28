defmodule StrongMigrations.LoaderTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Loader

  setup_all do
    Application.put_env(:strong_migrations, :migration_paths, [
      fixtures("migrations")
    ])
  end

  test "load empty list of migrations when directory is empty" do
    assert [] == Loader.load([fixtures("no_migrations")])
  end

  test "load empty list of migrations when directory does not exist" do
    assert [] == Loader.load([fixtures("not_existing_directory")])
  end

  test "load only .exs migrations when different extensions in directory" do
    expected_migration = fixtures("different_extensions/20210303123050_create_users_table.exs")

    assert [expected_migration] == Loader.load([fixtures("different_extensions")])
  end

  test "load migrations from the app configuration when not provided paths" do
    expected_migration = fixtures("migrations/20200202213700_create_users_table.exs")

    assert [expected_migration] == Loader.load([])
  end

  defp fixtures(migration) do
    "test/fixtures/loader/#{migration}"
  end
end
