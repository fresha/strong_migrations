defmodule RemoveColumn do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("posts") do
      remove(:title)
    end
  end
end
