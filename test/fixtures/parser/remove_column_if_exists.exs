defmodule RemoveColumnIfExists do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("posts") do
      remove_if_exists(:title)
    end
  end
end
