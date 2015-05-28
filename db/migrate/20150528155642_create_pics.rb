class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.belongs_to :cities
      t.belongs_to :users
      t.string :path
      t.timestamps null: false
    end
  end
end
