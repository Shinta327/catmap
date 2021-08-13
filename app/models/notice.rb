class Notice < ApplicationRecord
  # バリデーション
  with_options presence: true do
    # コメントの送り主と送り先の判別のためのバリデーション
    validates :resident_send_id,    unless: group_send_id?
    validates :resident_receive_id, unless: group_receive_id
    validates :group_send_id,       unless: resident_send_id?
    validates :group_receive_id,    unless: resident_receive_id?
    validates :comment_id
  end

  # boolean型のためのバリデーション
  validates :check,    inclusion: { in: [true, false] }
end
