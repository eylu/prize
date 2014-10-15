class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name
      t.string :code
      t.text :note
      t.integer :flg
      t.integer :quantity

      t.timestamps
    end
  end
end
