class AddPicTitleToPics < ActiveRecord::Migration
  def change
    change_table :pics do |t|
      t.string :pic_title
    end
  end
end
