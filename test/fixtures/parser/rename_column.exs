defmodule RenameColumn do
  @moduledoc false

  use Ecto.Migration

  def change do
    rename(table(:posts), :title, to: :summary)
  end
end
