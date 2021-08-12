class CreateFaileds < ActiveRecord::Migration[5.2]
  def change
    create_table :faileds do |t|
      t.integer :cat_id, null: false
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
