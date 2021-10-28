defmodule DisableDdlTransactionTrue do
  @moduledoc false

  use Ecto.Migration

  @disable_ddl_transaction true

  def change do
  end
end
