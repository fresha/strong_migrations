defmodule StrongMigrations.Classifiers.DropTable do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{drop_table: true}), do: failed()
  def classify(_migration), do: :ok

  defp failed, do: {:error, :drop_table_is_not_safety_assured}
end
