class AddPhotoUrlToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :photo_url, :string
  end
end
