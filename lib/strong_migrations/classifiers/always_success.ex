defmodule StrongMigrations.Classifiers.AlwaysSuccess do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(_migration), do: :ok
end
