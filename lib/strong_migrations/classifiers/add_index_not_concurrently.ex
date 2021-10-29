defmodule StrongMigrations.Classifiers.AddIndexNotConcurrently do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{create_index: true, create_index_concurrently: false, safety_assured: safety_assured}) do
    is_safe(:create_index in safety_assured)
  end

  def classify(%{create_index: true, create_index_concurrently: false}), do: failed()

  def classify(_migration), do: :ok

  defp is_safe(true), do: :ok
  defp is_safe(false), do: failed()

  defp failed do
    {:error, :add_index_not_concurrently}
  end
end
