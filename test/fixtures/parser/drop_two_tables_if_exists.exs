defmodule DropTwoTablesIfExists do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop_if_exists(table("posts"))
    drop_if_exists(table("users"))
  end
end
