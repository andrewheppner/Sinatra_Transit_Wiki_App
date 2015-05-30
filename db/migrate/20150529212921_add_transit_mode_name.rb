class AddTransitModeName < ActiveRecord::Migration
  def change
    change_table :transit_modes do |t|
      t.string :name
    end
  end
end
