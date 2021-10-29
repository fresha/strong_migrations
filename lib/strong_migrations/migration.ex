defmodule StrongMigrations.Migration do
  @moduledoc """
  Represents details related to a specific migration
  """

  use TypedStruct

  typedstruct do
    field(:file_path, String.t(), default: "")
    field(:disable_ddl_transaction, boolean(), default: false)
    field(:disable_migration_lock, boolean(), default: false)
    field(:create_index, boolean(), default: false)
    field(:drop_index, boolean(), default: false)
    field(:create_index_concurrently, boolean(), default: false)
    field(:drop_index_concurrently, boolean(), default: false)
    field(:rename_column, boolean(), default: false)
    field(:remove_column, boolean(), default: false)
    field(:safety_assured, [:atom], default: [])
  end

  @spec new(String.t()) :: t()
  def new(file_path) do
    %__MODULE__{file_path: file_path}
  end
end
