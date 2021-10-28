defmodule Mix.Tasks.StrongMigrations.Migrate do
  @moduledoc """
  Task which is an additional layer between the Ecto and StrongMigrations.
  Thanks to that we could run analyze of migrations and if it's fine - just run `ecto.migrate` task
  """

  use Mix.Task

  alias StrongMigrations

  def run(args) do
    case StrongMigrations.analyze() do
      :safe -> Mix.Task.run("ecto.migrate", args)
      {:unsafe, reasons} -> handle_reasons(reasons)
    end
  end

  defp handle_reasons(reasons) do
    Enum.map(reasons, fn reason -> IO.warn(reason) end)
  end
end
