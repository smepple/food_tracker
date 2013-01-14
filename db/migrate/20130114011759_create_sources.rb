class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.integer :author_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
