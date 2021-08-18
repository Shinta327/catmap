class Handle < ApplicationRecord
  # アソシエーション
  belongs_to :cat

  # バリデーション
  with_options presence: true do
    validates :cat_id
     # ステータスが1以上（対応中、対応完了）の場合not null
    validates :group_id,  if: -> { status_before_type_cast >= "1" }
    # ステータスが２（対応完了）の場合not null
    validates :detail,    if: -> { status_before_type_cast == "2" }
  end

  # enumの設定
  enum status: {
    未対応: 0,
    対応中: 1,
    対応完了: 2
  }

  # enumのバリデーション
  # enum設定の下にvalidatetionを持ってこないとstatusesを認識してくれない？ので下記にvalidation記載
  validates :status,      inclusion: { in: Handle.statuses.keys }
end
