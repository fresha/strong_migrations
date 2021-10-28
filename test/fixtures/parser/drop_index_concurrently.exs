defmodule DropIndexConcurrently do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop(index(:users, :email, concurrently: true))
  end
end
