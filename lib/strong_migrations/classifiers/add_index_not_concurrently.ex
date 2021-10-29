defmodule StrongMigrations.Classifiers.AddIndexNotConcurrently do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{create_index: true, create_index_concurrently: false}), do: failed()

  def classify(_migration), do: :ok

  defp failed do
    {:error, :add_index_not_concurrently}
  end
end
