defmodule StrongMigrations.Validator do
  @moduledoc """
  Validates incoming migration's data if they meet requirements or need to be updated
  """

  alias StrongMigrations.Migration

  @spec validate([Migration.t()]) :: :ok
  def validate(migrations) do
    Enum.map(migrations, &apply_classifiers(&1, classifiers()))
  end

  defp apply_classifiers(migration, classifiers) do
    Enum.reduce(classifiers, [], fn classifier, acc ->
      case classifier.classify(migration) do
        :ok -> acc
        {:error, error} -> acc ++ [error]
      end
    end)
  end

  defp classifiers do
    Application.fetch_env!(:strong_migrations, :classifiers)
  end
end
