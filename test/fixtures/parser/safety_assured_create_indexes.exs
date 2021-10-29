defmodule SafetyAssuredCreateIndex do
  @moduledoc false

  import StrongMigrations
  use Ecto.Migration

  def change do
    safety_assured do
      create(index(:users, :name))
      create(index(:users, :email))
    end
  end
end
