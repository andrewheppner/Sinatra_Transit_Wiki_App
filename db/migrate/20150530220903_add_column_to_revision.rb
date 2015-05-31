class AddColumnToRevision < ActiveRecord::Migration
  def change
     change_table :revisions do |t|
      t.string :columns_name
      t.remove :problem
    end
  end
end
