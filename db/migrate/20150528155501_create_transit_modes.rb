class CreateTransitModes < ActiveRecord::Migration
  
  def change
    create_table :transit_modes do |t|
      t.string :fare
      t.string :transfers
      t.belongs_to :city
      t.timestamps null: false
    end
  end
  
end
