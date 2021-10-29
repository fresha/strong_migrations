defmodule CreateIndexConcurrentlyManyOptions do
  @moduledoc false

  use Ecto.Migration

  def change do
    create(
      index(
        :users,
        :email,
        where: "type = 0",
        unique: true,
        name: "yolo",
        concurrently: true
      )
    )
  end
end
