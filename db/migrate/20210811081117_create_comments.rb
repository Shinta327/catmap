class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :resident_id
      t.integer :group_id
      t.integer :cat_id,  null: false
      t.text :comment,    null: false
      t.timestamps
    end
  end
end
