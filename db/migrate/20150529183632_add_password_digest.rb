class AddPasswordDigest < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :hashed_password
      t.string :password_digest
    end
  end
end
