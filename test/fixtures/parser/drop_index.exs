defmodule DropIndex do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop(index(:users, :email))
  end
end
