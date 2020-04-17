class AddDeletedAtToEndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :end_users, :deleted_at, :datetime
  end
end
