class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.belongs_to :city
      t.belongs_to :user
      t.string :path
      t.timestamps null: false
    end
  end
end
