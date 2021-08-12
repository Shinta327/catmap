class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.integer :resident_send_id
      t.integer :residnet_receive_id
      t.integer :group_send_id
      t.integer :group_receive_id
      t.integer :comment_id, null: false
      t.boolean :check, null: false, default: false

      t.timestamps
    end
  end
end
