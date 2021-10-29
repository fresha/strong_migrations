defmodule StrongMigrations.Classifiers.RenameColumn do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{rename_column: true, safety_assured: safety_assured}) do
    is_safe(:rename_column in safety_assured)
  end

  def classify(%{rename_column: true}), do: failed()
  def classify(_migration), do: :ok

  defp is_safe(true), do: :ok
  defp is_safe(false), do: failed()

  defp failed, do: {:error, :rename_column_is_not_safe}
end
