class AddPicToUserProfile < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :pic_url
    end
  end
end
