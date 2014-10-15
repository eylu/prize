class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name
      t.string :password_hash
      t.string :salt
      t.integer :flg

      t.timestamps
    end
  end
end
