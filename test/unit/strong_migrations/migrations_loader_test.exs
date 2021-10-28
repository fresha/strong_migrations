defmodule StrongMigrations.MigrationsLoaderTest do
  use ExUnit.Case

  alias StrongMigrations.MigrationsLoader

  test "load empty list of migrations when directory is empty" do
    assert [] == MigrationsLoader.load(["test/fixtures/no_migrations"])
  end

  test "load empty list of migrations when directory does not exist" do
    assert [] == MigrationsLoader.load(["test/fixtures/not_existing_directory"])
  end

  test "load only .exs migrations when different extensions in directory" do
    expected_migration =
      "test/fixtures/different_extensions/20210303123050_create_users_table.exs"

    assert [expected_migration] == MigrationsLoader.load(["test/fixtures/different_extensions"])
  end

  test "load migrations from the app configuration when not provided paths" do
    expected_migration = "test/fixtures/migrations/20200202213700_create_users_table.exs"

    assert [expected_migration] == MigrationsLoader.load([])
  end
end
