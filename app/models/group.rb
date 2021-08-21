class Group < ApplicationRecord
  has_many :comments, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションの設定

  # 郵便番号の正規表現（ハイフンなし7桁）
  VALID_POSTAL_CODE_REGIX = /\A\d{7}\z/

  with_options presence: true do
    validates :name
    validates :postal_code, format: { with: VALID_POSTAL_CODE_REGIX }
    validates :address
    validates :url
    validates :explanation
  end

  # boolean型のバリデーション
  validates :withdrawal,    inclusion: { in: [true, false] }

  # geocoderで住所カラムから経度・緯度に変換し保存するための記述
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
end
