class AddIconColumnToTransitModes < ActiveRecord::Migration
  def change

    change_table :transit_modes do |t|
      t.string :icon
    end
    
  end
end
