defmodule StrongMigrations.Validator do
  @moduledoc """
  Validates incoming migration's data if they meet requirements or need to be updated
  """

  alias StrongMigrations.Migration

  @spec validate([Migration.t()]) :: [StrongMigrations.validation_result()]
  def validate(migrations) do
    Enum.map(migrations, fn migration ->
      {migration.file_path, apply_classifiers(migration, classifiers())}
    end)
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
