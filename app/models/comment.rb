class Comment < ApplicationRecord
  belongs_to :cat
  belongs_to :group, optional: true
  belongs_to :resident, optional: true

  # バリデーション
  with_options presence: true do
    validates :cat_id
    validates :comment,     length: { maximum: 500 }
     # 条件分岐によるバリデーション（コメントが保護団体か住民かを分けるためのバリデーション）
    validates :resident_id, if: -> { group_id.blank? }
    validates :group_id,    if: -> { resident_id.blank? }
  end

end
