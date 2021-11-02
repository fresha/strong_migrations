defmodule StrongMigrations.Loader do
  @moduledoc """
  Loads migration files from a given paths
  """

  @doc """
  Returns a list of migration files in specified paths (`:migration_paths`).
  """
  @spec load([StrongMigrations.migration_path()]) :: [StrongMigrations.migration_file()]
  def load(paths) do
    paths
    |> get_migration_paths()
    |> Enum.flat_map(fn path ->
      path
      |> Path.join("*.exs")
      |> Path.wildcard()
      |> Enum.uniq()
    end)
  end

  defp get_migration_paths([]) do
    Application.get_env(:strong_migrations, :migration_paths, [
      "priv/repo/migrations",
      "apps/*/priv/repo/migrations"
    ])
  end

  defp get_migration_paths(paths), do: paths
end
