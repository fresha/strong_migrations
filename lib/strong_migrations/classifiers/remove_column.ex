defmodule StrongMigrations.Classifiers.RemoveColumn do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{remove_column: true, safety_assured: safety_assured}) do
    is_safe(:remove_column in safety_assured)
  end

  def classify(%{remove_column: true}), do: failed()
  def classify(_migration), do: :ok

  defp is_safe(true), do: :ok
  defp is_safe(false), do: failed()

  defp failed, do: {:error, :remove_column_is_not_safety_assured}
end
