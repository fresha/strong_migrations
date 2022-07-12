defmodule StrongMigrations.Classifiers.DefaultIsFunctionTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Classifiers.DefaultIsFunction
  alias StrongMigrations.Migration

  test "it has failed when trying to drop a table" do
    migration = %{Migration.new("test.exs") | default_is_function: true}

    assert {:error, :function_as_default_is_not_safety_assured} ==
             DefaultIsFunction.classify(migration)
  end

  test "it has passed when not drop a table" do
    migration = %{Migration.new("test.exs") | default_is_function: false}

    assert :ok == DefaultIsFunction.classify(migration)
  end
end
