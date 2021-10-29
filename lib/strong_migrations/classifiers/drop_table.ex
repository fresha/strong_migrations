defmodule StrongMigrations.Classifiers.DropTable do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{drop_table: true, safety_assured: safety_assured}) do
    is_safe(:drop_table in safety_assured)
  end

  def classify(%{drop_table: true}), do: failed()
  def classify(_migration), do: :ok

  defp is_safe(true), do: :ok
  defp is_safe(false), do: failed()

  defp failed, do: {:error, :drop_table_is_not_safety_assured}
end
