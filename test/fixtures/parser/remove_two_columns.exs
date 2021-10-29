defmodule RemoveTwoColumns do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("posts") do
      remove(:title)
      remove(:description)
    end
  end
end
