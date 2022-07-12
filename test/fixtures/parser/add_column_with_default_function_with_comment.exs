defmodule AddColumnWithFuncDefault do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("test") do
      add(:col, :uuid, default: fragment("uuid_generate_v4() -- comment"))
    end
  end
end
