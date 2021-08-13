class Cat < ApplicationRecord
  # refileのための記述
  attachment :image
  
  # バリデーション
  with_options presence: true do
    validates :resident_id
    validates :address
    validates :latitude
    validates :longitude
    validates :detail, length: { minimum: 50 }
  end
end
