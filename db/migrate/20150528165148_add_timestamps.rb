class AddTimestamps < ActiveRecord::Migration
  def change
    add_timestamps :users
    add_timestamps :transit_modes
    add_timestamps :pics
    add_timestamps :cities
  end
end
