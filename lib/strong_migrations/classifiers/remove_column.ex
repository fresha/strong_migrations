defmodule StrongMigrations.Classifiers.RemoveColumn do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{remove_column: true}), do: failed()
  def classify(_migration), do: :ok

  defp failed, do: {:error, :remove_column_is_not_safety_assured}
end
