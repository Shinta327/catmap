class Notice < ApplicationRecord
  # データの取得を作成日時の降順
  default_scope -> { order(created_at: :desc) }
  # アソシエーション
  belongs_to :comment
  belongs_to :resident_send, class_name: 'Resident', foreign_key: 'resident_send_id', optional: true
  belongs_to :resident_receive, class_name: 'Resident', foreign_key: 'resident_receive_id', optional: true
  belongs_to :group_send, class_name: 'Group', foreign_key: 'group_send_id', optional: true
  belongs_to :group_receive, class_name: 'Group', foreign_key: 'group_receive_id', optional: true

  # バリデーション
  with_options presence: true do
    # コメントの送り主と送り先の判別のためのバリデーション
    validates :resident_send_id,    if: -> { group_send_id.blank? }
    validates :resident_receive_id, if: -> { group_receive_id.blank? }
    validates :group_send_id,       if: -> { resident_send_id.blank? }
    validates :group_receive_id,    if: -> { resident_receive_id.blank? }
    validates :comment_id
  end

  # boolean型のためのバリデーション
  validates :check,    inclusion: { in: [true, false] }
end
