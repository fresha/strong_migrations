defmodule AddColumnWithSequentialDefault do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table("test") do
      add(:sequntial_id, :integer, default: fragment("next_val(products_product_no_seq)"))
    end
  end
end
