defmodule DropTableAndRemoveColumn do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop(table(:users))

    alter table(:posts) do
      remove(:title)
    end
  end
end
