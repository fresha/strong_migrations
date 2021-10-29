defmodule RemoveTwoColumnsIfExists do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("posts") do
      remove_if_exists(:title)
      remove_if_exists(:description)
    end
  end
end
