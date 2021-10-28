defmodule StrongMigrations.Classifiers.AlwaysFailed do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(_migration), do: {:error, :failed}
end
