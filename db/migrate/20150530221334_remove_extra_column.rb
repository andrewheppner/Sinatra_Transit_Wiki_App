class RemoveExtraColumn < ActiveRecord::Migration
  def change
     change_table :revisions do |t|
      t.remove :columns_name
    end
  end
end
