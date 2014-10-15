class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.integer :award_id
      t.string :award_name

      t.timestamps
    end
    add_index :users, :award_id
    add_index :users, :phone
  end
end
