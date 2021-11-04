defmodule SafetyAssuredCreateIndex do
  @moduledoc false

  use StrongMigrations

  def change do
    safety_assured(do: create(index(:users, :email)))
  end
end
