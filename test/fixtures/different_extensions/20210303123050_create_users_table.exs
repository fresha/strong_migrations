defmodule StrongMigrations.Repo.Migrations.CreateUsersTable do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)

      timestamps()
    end
  end
end
