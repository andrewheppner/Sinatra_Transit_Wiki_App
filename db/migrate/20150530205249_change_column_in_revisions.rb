class ChangeColumnInRevisions < ActiveRecord::Migration
  def change
    change_table :revisions do |t|
      t.remove :column_name
      t.string :problem
    end
  end
end
