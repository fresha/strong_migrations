defmodule DisableMigrationLockFalse do
  @moduledoc false

  use Ecto.Migration

  @disable_migration_lock false

  def change do
  end
end
