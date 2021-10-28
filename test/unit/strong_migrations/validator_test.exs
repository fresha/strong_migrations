defmodule StrongMigrations.ValidatorTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Migration
  alias StrongMigrations.Validator

  setup do
    on_exit(&reset_classifiers/0)
  end

  test "validation failed when classificator has applied an error" do
    expect_always_success_classifier()

    [{_file, errors}] =
      [example_migration()]
      |> Validator.validate()

    assert errors == []
  end

  test "validation success when classificator has applied ok status" do
    expect_always_failed_classifier()

    [{_file, errors}] =
      [example_migration()]
      |> Validator.validate()

    assert errors == [:failed]
  end

  defp example_migration, do: Migration.new("test.exs")

  defp expect_always_success_classifier do
    Application.put_env(:strong_migrations, :classifiers, [
      StrongMigrations.Classifiers.AlwaysSuccess
    ])
  end

  defp expect_always_failed_classifier do
    Application.put_env(:strong_migrations, :classifiers, [
      StrongMigrations.Classifiers.AlwaysFailed
    ])
  end

  defp reset_classifiers do
    Application.put_env(:strong_migrations, :classifiers, [])
  end
end
