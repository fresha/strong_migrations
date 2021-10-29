defmodule StrongMigrations.Classifiers.RenameColumnIsNotSafe do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{rename_column: true}), do: failed()

  def classify(_migration), do: :ok

  defp failed do
    {:error, :rename_column_is_not_safe}
  end
end
