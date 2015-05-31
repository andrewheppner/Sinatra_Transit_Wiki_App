class RenamePicTitle < ActiveRecord::Migration
  def change
    rename_column :pics, :pic_title, :title
  end
end
