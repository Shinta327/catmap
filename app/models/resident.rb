class Resident < ApplicationRecord
  # アソシエーション
  has_many :cats, dependent: :destroy
  has_many :comments, dependent: :destroy
  # 通知機能用のアソシエーション
  # 自分からの通知
  has_many :active_notifications, class_name: 'Notice', foreign_key: 'resident_send_id', dependent: :destroy
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notice', foreign_key: 'resident_receive_id', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  # 郵便番号の正規表現（ハイフンなし7桁）
  VALID_POSTAL_CODE_REGIX = /\A\d{7}\z/

  with_options presence: true do
    validates :name
    validates :postal_code
    validates :address
  end

  validates :postal_code, format: { with: VALID_POSTAL_CODE_REGIX}, allow_blank: true

  # boolean型のバリデーション
  validates :withdrawal,    inclusion: { in: [true, false] }

  # geocoderで住所カラムから経度・緯度に変換し保存するための記述
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
