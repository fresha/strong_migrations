defmodule StrongMigrationsTest do
  use ExUnit.Case
  doctest StrongMigrations

  test "project has been analyzed successfully" do
    assert StrongMigrations.analyze() == :ok
  end
end
