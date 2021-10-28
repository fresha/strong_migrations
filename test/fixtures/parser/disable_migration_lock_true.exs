defmodule DisableMigrationLockTrue do
  @moduledoc false

  use Ecto.Migration

  @disable_migration_lock true

  def change do
  end
end
