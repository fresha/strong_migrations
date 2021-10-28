defmodule Mix.Tasks.StrongMigrations.Migrate do
  @moduledoc """
  Task which is an additional layer between the Ecto and StrongMigrations.
  Thanks to that we could run analyze of migrations and if it's fine - just run `ecto.migrate` task
  """

  use Mix.Task

  def run(_command_line_args) do
    Mix.Task.run("ecto.migrate")
  end
end
