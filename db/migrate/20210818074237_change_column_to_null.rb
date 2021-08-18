class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
  # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
  change_column_null :handles, :detail, true
  change_column_null :handles, :cat_id, false
  end

  def down
    change_column_null :handles, :detail, false
    change_column_null :handles, :cat_id, true
  end
end
