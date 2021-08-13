class Notice < ApplicationRecord
  # バリデーション
  with_options presence: true do
    # コメントの送り主と送り先の判別のためのバリデーション
    validates :resident_send_id,    if: Proc.new { |a| a.group_send_id.blank? }
    validates :resident_receive_id, if: Proc.new { |a| a.group_receive_id.blank? }
    validates :group_send_id,       if: Proc.new { |a| a.resident_send_id.blank? }
    validates :group_receive_id,    if: Proc.new { |a| a.resident_receive_id.blank? }
    validates :comment_id
  end

  # boolean型のためのバリデーション
  validates :check,    inclusion: { in: [true, false] }
end
