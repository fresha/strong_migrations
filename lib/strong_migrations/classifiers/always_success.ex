defmodule StrongMigrations.Classifiers.AlwaysSuccess do
  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(_migration), do: :ok
end
