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
             "Migration do_something.exs is not safe! Reason: i like trains",
             "Migration do_something.exs is not safe! Reason: elixir is cool"
           ] == reasons
  end
end
