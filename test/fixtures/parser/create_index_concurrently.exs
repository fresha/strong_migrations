defmodule CreateIndexConcurrently do
  @moduledoc false

  use Ecto.Migration

  def change do
    create(index(:users, :email, concurrently: true))
  end
end
