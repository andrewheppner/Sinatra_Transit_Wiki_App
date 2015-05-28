class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.belongs_to :users
      t.belongs_to :transit_modes
      t.string :column_name
      t.datetime :before_created_at
      t.datetime :after_created_at
      t.timestamps null:false 
    end
  end
end
