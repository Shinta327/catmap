class RenameResidentIdColumnToHandles < ActiveRecord::Migration[5.2]
  def change
    rename_column :handles, :resident_id, :group_id
  end
end
