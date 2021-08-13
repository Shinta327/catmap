class Comment < ApplicationRecord
  # バリデーション
  with_options presence: true do
    validates :cat_id
    validates :comment,     length: { maximum: 500 }
     # 条件分岐によるバリデーション（コメントが保護団体か住民かを分けるためのバリデーション）
    validates :resident_id, if: Proc.new { |a| a.group_id.blank? }
    validates :group_id,    if: Proc.new { |a| a.resident_id.blank? }
  end

end
