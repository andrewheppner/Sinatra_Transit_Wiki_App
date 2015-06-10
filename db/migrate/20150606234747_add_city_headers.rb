class AddCityHeaders < ActiveRecord::Migration
  def change
    add_column :cities, :header, :string
  end
end
