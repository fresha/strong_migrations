defmodule StrongMigrationsTest do
  use ExUnit.Case
  doctest StrongMigrations

  test "greets the world" do
    assert StrongMigrations.hello() == :world
  end
end
