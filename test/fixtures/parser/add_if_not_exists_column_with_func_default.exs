defmodule AddColumnWithFuncDefault do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("test") do
      add_if_not_exists(:col, :uuid, default: fragment("uuid_generate_v4()"))
    end
  end
end
