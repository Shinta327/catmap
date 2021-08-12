class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.integer :resident_id, null: false
      t.text :address,        null: false
      t.float :latitude,      null: false
      t.float :longitude,     null: false
      # refile用のカラムなのでidを使用
      t.string :image_id

      t.text :detail, null: false

      t.timestamps
    end
  end
end
