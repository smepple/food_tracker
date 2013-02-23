class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :dish_id
      t.integer :user_id
      t.text :content
      t.string :ancestry

      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
