defmodule DropTableIfExists do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop_if_exists(table("posts"))
  end
end
