class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.string :name, null: false
      t.string :image_id
      t.text :introduction, null: false
      t.boolean :is_sale, default: true, null: false


      t.timestamps
    end
  end
end


