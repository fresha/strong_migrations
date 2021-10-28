defmodule StrongMigrations.Classifiers.AlwaysFailed do
  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(_migration), do: {:error, :failed}
end
