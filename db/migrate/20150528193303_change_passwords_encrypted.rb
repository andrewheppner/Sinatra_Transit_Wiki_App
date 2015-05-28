class ChangePasswordsEncrypted < ActiveRecord::Migration
  def change

    change_table :users do |t|
      t.remove :password
      t.string :hashed_password
    end
  end
end
