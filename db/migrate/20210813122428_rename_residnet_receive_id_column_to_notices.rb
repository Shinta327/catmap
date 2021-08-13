class RenameResidnetReceiveIdColumnToNotices < ActiveRecord::Migration[5.2]
  def change
     rename_column :notices, :residnet_receive_id, :resident_receive_id
  end
end
