defmodule ModifyColumnWithFuncDefault do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("test") do
      modify(:col, :uuid, default: fragment("uuid_generate_v4()"))
    end
  end
end
