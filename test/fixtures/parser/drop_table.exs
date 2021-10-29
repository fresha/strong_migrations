defmodule DropTable do
  @moduledoc false

  use Ecto.Migration

  def change do
    drop(table("posts"))
  end
end
