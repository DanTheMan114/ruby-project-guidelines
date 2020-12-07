class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :hexcode
      t.string :emoji
      t.string :name
      t.string :category
      t.string :tags
      t.integer :price
      t.timestamps
    end

  end
end
