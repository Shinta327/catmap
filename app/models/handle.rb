class Handle < ApplicationRecord
  # バリデーション
  with_options presence: true do
    validates :cat_id
     # ステータスが1以上（対応中、対応完了）の場合not null
    validates :group_id,  if: Proc.new { |a| a.status >= 1 }
    # ステータスが２（対応完了）の場合not null
    validates :detail,    if: Proc.new { |a| a.status == 2 }
  end

  # enumのバリデーション
  validates :status,      inclusion: { in: [0..2] }

  # enumの設定
  enum status: {
    未対応: 0,
    対応中: 1,
    対応完了: 2
  }
end
