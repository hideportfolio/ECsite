class AddColumnToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :genre_id, :integer
    add_column :items, :price_before_tax, :integer

  end
end
