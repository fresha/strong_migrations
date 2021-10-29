defmodule CreateUniqueIndex do
  @moduledoc false

  use Ecto.Migration

  def change do
    create(unique_index(:users, :email))
  end
end
