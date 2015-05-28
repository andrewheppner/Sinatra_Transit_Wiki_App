class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do 
      t.belongs_to :cities
      t.belong_to :users
      t.string :path
    end
  end
end
