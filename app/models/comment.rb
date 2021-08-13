class Comment < ApplicationRecord
  # バリデーション
  with_options presence: true do
    validates :cat_id
    validates :comment,     length: { maximmum: 500 }
     # 条件分岐によるバリデーション（コメントが保護団体か住民かを分けるためのバリデーション）
    validates :resident_id, unless: group_id?
    validates :group_id,    unless: resident_id?
  end

end
