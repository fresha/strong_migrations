defmodule RenameTwoColumns do
  @moduledoc false

  use Ecto.Migration

  def change do
    rename(table(:users), :name, to: :full_name)
    rename(table(:users), :user_age, to: :age)
  end
end
