class Comment < ApplicationRecord
  belongs_to :cat
  belongs_to :group, optional: true
  belongs_to :resident, optional: true
  # 通知用アソシエーション
  has_many :notices, dependent: :destroy

  # バリデーション
  with_options presence: true do
    validates :cat_id
    validates :comment,     length: { maximum: 500 }
     # 条件分岐によるバリデーション（コメントが保護団体か住民かを分けるためのバリデーション）
    validates :resident_id, if: -> { group_id.blank? }
    validates :group_id,    if: -> { resident_id.blank? }
  end

  # residentが投稿にコメントした時
  def send_resident_comment(resident_send_id, group_receive_id)
    notification = Resident.find(resident_send_id).active_notifications.new(
      comment_id: id,
      resident_send_id: resident_send_id,
      group_receive_id: group_receive_id
      )
    notification.save if notification.valid?
  end

  # groupが投稿にコメントした時
  def send_group_comment(group_send_id, resident_receive_id)
    notification = Group.find(group_send_id).active_notifications.new(
      comment_id: id,
      group_send_id: group_send_id,
      resident_receive_id: resident_receive_id
      )
    notification.save if notification.valid?
  end
end
