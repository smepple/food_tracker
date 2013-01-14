class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.date :eat_date
      t.integer :prep_time
      t.integer :category_id
      t.integer :source_id
      t.integer :source_page

      t.timestamps
    end
  end
end
