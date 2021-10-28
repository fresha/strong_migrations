defmodule DisableDdlTransactionFalse do
  @moduledoc false

  use Ecto.Migration

  @disable_ddl_transaction false

  def change do
  end
end
