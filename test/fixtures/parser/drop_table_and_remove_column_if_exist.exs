defmodule DropTableAndRemoveColumnIfExist do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop(table(:users))

    alter table(:posts) do
      remove_if_exist(:title)
    end
  end
end
