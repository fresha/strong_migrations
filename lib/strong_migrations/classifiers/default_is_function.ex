defmodule StrongMigrations.Classifiers.DefaultIsFunction do
  @moduledoc false

  alias StrongMigrations.Classifier

  @behaviour Classifier

  @impl Classifier
  def classify(%{default_is_function: true}), do: failed()
  def classify(_migration), do: :ok

  defp failed, do: {:error, :function_as_default_is_not_safety_assured}
end
