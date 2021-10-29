defmodule StrongMigrations.ReasonsTranslator do
  @moduledoc """
  Module responsible for translating atom errors into human readable communicates
  """

  @spec translate([StrongMigrations.validation_result()]) ::
          :safe | {:unsafe, [StrongMigrations.reason()]}
  def translate(results) do
    results
    |> Enum.reject(fn {_migration, reasons} -> reasons == [] end)
    |> Enum.flat_map(&to_human_readable/1)
    |> case do
      [] -> :safe
      reasons -> {:unsafe, reasons}
    end
  end

  defp to_human_readable({migration, reasons}) do
    Enum.map(reasons, fn reason ->
      """
      Unsafe migration! Reason: #{readable_reason(reason)}
      File: #{migration}
      """
    end)
  end

  defp readable_reason(reason) do
    reason |> Atom.to_string() |> String.replace("_", " ")
  end
end
