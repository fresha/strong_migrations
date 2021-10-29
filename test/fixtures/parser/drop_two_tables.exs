defmodule DropTwoTables do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop(table("posts"))
    drop(table("users"))
  end
end
