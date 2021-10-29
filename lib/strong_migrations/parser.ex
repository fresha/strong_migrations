defmodule StrongMigrations.Parser do
  @moduledoc """
  The module responsible for reading an ASTand generating a bucket of the information of migration's content
  """

  alias StrongMigrations.Migration

  @doc """
  Parses given migrations into a struct with information about the content
  """
  @spec parse([StrongMigrations.migration_file()]) :: :ok
  def parse(migration_files) do
    migration_files
    |> Stream.map(&file_path_to_ast/1)
    |> Stream.map(&analyze_code/1)
    |> Enum.to_list()
  end

  defp file_path_to_ast(file_path) do
    {file_path,
     file_path
     |> File.read!()
     |> Code.string_to_quoted!()}
  end

  defp analyze_code({file_path, {:defmodule, _, [_, [do: {:__block__, _, body}]]}}) do
    parse_body(body, Migration.new(file_path))
  end

  defp analyze_code({file_path, _}), do: Migration.new(file_path)

  defp parse_body([{:use, _, _} | tail], acc), do: parse_body(tail, acc)

  defp parse_body([{:@, _, [{:safety_assured, _, [operations]}]} | tail], acc) do
    parse_body(tail, %{acc | safety_assured: operations})
  end

  defp parse_body([{:@, _, [{:disable_ddl_transaction, _, [true]}]} | tail], acc) do
    parse_body(tail, %{acc | disable_ddl_transaction: true})
  end

  defp parse_body([{:@, _, [{:disable_migration_lock, _, [true]}]} | tail], acc) do
    parse_body(tail, %{acc | disable_migration_lock: true})
  end

  defp parse_body(
         [{:def, _, [_, [do: {:create, _, [{:index, _, [_, _, [concurrently: true]]}]}]]} | tail],
         acc
       ) do
    parse_body(tail, %{acc | create_index_concurrently: true})
  end

  defp parse_body(
         [
           {:def, _, [_, [do: {:create, _, [{:unique_index, _, [_, _, [concurrently: true]]}]}]]}
           | tail
         ],
         acc
       ) do
    parse_body(tail, %{acc | create_index_concurrently: true})
  end

  defp parse_body(
         [{:def, _, [_, [do: {:create, _, [{:index, _, [_, _, opts]}]}]]} | tail],
         acc
       ) do
    parse_body(tail, %{acc | create_index_concurrently: Keyword.get(opts, :concurrently, false)})
  end

  defp parse_body(
         [{:def, _, [_, [do: {:create, _, [{:unique_index, _, [_, _, opts]}]}]]} | tail],
         acc
       ) do
    parse_body(tail, %{acc | create_index_concurrently: Keyword.get(opts, :concurrently, false)})
  end

  defp parse_body(
         [{:def, _, [_, [do: {:drop, _, [{:index, _, [_, _, [concurrently: true]]}]}]]} | tail],
         acc
       ) do
    parse_body(tail, %{acc | drop_index_concurrently: true})
  end

  defp parse_body([{:def, _, [_, [do: {:create, _, [{:index, _, _}]}]]} | tail], acc) do
    parse_body(tail, %{acc | create_index: true})
  end

  defp parse_body([{:def, _, [_, [do: {:create, _, [{:unique_index, _, _}]}]]} | tail], acc) do
    parse_body(tail, %{acc | create_index: true})
  end

  defp parse_body([{:def, _, [_, [do: {:drop, _, [{:index, _, _}]}]]} | tail], acc) do
    parse_body(tail, %{acc | drop_index: true})
  end

  defp parse_body([{:def, _, [_, [do: {:drop, _, [{:table, _, _}]}]]} | tail], acc) do
    parse_body(tail, %{acc | drop_table: true})
  end

  defp parse_body([{:def, _, [_, [do: {:drop_if_exists, _, [{:table, _, _}]}]]} | tail], acc) do
    parse_body(tail, %{acc | drop_table: true})
  end

  defp parse_body(
         [
           {:def, _,
            [_, [do: {:rename, _, [{:table, _, [_table]}, _column_name, [to: _new_column_name]]}]]}
           | tail
         ],
         acc
       ) do
    parse_body(tail, %{acc | rename_column: true})
  end

  defp parse_body(
         [
           {:def, _, [_, [do: {:alter, _, [{:table, _, _}, [do: {:__block__, _, opts}]]}]]} | tail
         ],
         acc
       ) do
    acc = parse_complex_body(opts, acc)

    parse_body(tail, acc)
  end

  defp parse_body([{:def, _, [_, [do: {:alter, _, opts}]]} | tail], acc) do
    acc = parse_complex_body(opts, acc)

    parse_body(tail, acc)
  end

  defp parse_body([{:def, _, [_, [do: {:__block__, _, opts}]]} | tail], acc) do
    acc = parse_complex_body(opts, acc)

    parse_body(tail, acc)
  end

  defp parse_body([_head | tail], acc) do
    parse_body(tail, acc)
  end

  defp parse_body([], acc), do: acc

  defp parse_complex_body([{:create, _, [{:index, _, [_, _, [concurrently: true]]}]} | tail], acc) do
    parse_complex_body(tail, %{acc | create_index_concurrently: true})
  end

  defp parse_complex_body(
         [{:create, _, [{:unique_index, _, [_, _, [concurrently: true]]}]} | tail],
         acc
       ) do
    parse_complex_body(tail, %{acc | create_index_concurrently: true})
  end

  defp parse_complex_body([{:create, _, [{:index, _, [_, _]}]} | tail], acc) do
    parse_complex_body(tail, %{acc | create_index: true})
  end

  defp parse_complex_body([{:create, _, [{:unique_index, _, [_, _]}]} | tail], acc) do
    parse_complex_body(tail, %{acc | create_index: true})
  end

  defp parse_complex_body([{:drop, _, [{:index, _, [_, _, [concurrently: true]]}]} | tail], acc) do
    parse_complex_body(tail, %{acc | drop_index_concurrently: true})
  end

  defp parse_complex_body([{:drop, _, [{:index, _, [_, _]}]} | tail], acc) do
    parse_complex_body(tail, %{acc | drop_index: true})
  end

  defp parse_complex_body(
         [{:rename, _, [{:table, _, [_table]}, _column_name, [to: _new_column_name]]} | tail],
         acc
       ) do
    parse_complex_body(tail, %{acc | rename_column: true})
  end

  defp parse_complex_body([[do: {:remove, _, [_column]}] | tail], acc) do
    parse_complex_body(tail, %{acc | remove_column: true})
  end

  defp parse_complex_body([[do: {:remove_if_exists, _, [_column]}] | tail], acc) do
    parse_complex_body(tail, %{acc | remove_column: true})
  end

  defp parse_complex_body([{:remove, _, [_column]} | tail], acc) do
    parse_complex_body(tail, %{acc | remove_column: true})
  end

  defp parse_complex_body([{:remove_if_exists, _, [_column]} | tail], acc) do
    parse_complex_body(tail, %{acc | remove_column: true})
  end

  defp parse_complex_body(
         [{:alter, _, [{:table, _, [_table]}, [do: {:remove, _, [_column]}]]} | tail],
         acc
       ) do
    parse_complex_body(tail, %{acc | remove_column: true})
  end

  defp parse_complex_body(
         [{:alter, _, [{:table, _, [_table]}, [do: {:remove_if_exist, _, [_column]}]]} | tail],
         acc
       ) do
    parse_complex_body(tail, %{acc | remove_column: true})
  end

  defp parse_complex_body([{:drop, _, [{:table, _, _table_name}]} | tail], acc) do
    parse_complex_body(tail, %{acc | drop_table: true})
  end

  defp parse_complex_body([{:drop_if_exists, _, [{:table, _, _table_name}]} | tail], acc) do
    parse_complex_body(tail, %{acc | drop_table: true})
  end

  defp parse_complex_body([_head | tail], acc) do
    parse_complex_body(tail, acc)
  end

  defp parse_complex_body([], acc), do: acc
end
