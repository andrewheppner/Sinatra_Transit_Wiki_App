class ChangePasswordsEncrypted < ActiveRecord::Migration
  def change

    change_table :users do |t|
      t.remove :passwords
      t.string :hashed_password
    end
  end
end
