defmodule SafetyAssuredOneOfTwoOpts do
  @moduledoc false

  use StrongMigrations

  def change do
    safety_assured(do: create(index(:users, :email)))

    drop(table(:posts))
  end
end
