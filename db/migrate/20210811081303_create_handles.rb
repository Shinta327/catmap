class CreateHandles < ActiveRecord::Migration[5.2]
  def change
    create_table :handles do |t|
      t.integer :resident_id
      t.integer :cat_id,    nul: false
      t.integer :status,    null: false, default: 0
      t.text :detail,       null: false

      t.timestamps
    end
  end
end
