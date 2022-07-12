defmodule AddColumnWithDefaultValue do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("test") do
      add(:sequntial_id, :integer, default: 0)
    end
  end
end
