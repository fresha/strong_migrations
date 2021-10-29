defmodule StrongMigrations.ReasonsTranslatorTest do
  use ExUnit.Case, async: true

  alias StrongMigrations.ReasonsTranslator

  test "translates to safe when no specified reasons for migrations" do
    to_translate = [
      {"migration.exs", []}
    ]

    assert :safe == ReasonsTranslator.translate(to_translate)
  end

  test "translates unsafe when migrations with reasons specified" do
    to_translate = [
      {"do_something.exs", [:i_like_trains, :elixir_is_cool]}
    ]

    {status, reasons} = ReasonsTranslator.translate(to_translate)

    assert :unsafe == status

    assert [
             "Unsafe migration! Reason: i like trains\nFile: do_something.exs\n",
             "Unsafe migration! Reason: elixir is cool\nFile: do_something.exs\n"
           ] == reasons
  end
end
