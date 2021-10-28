defmodule StrongMigrations.ParserTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.Parser

  setup_all do
    Application.put_env(:strong_migrations, :migration_paths, [
      "test/fixtures/migrations"
    ])
  end
end
