class Cat < ApplicationRecord
  # アソシエーション
  belongs_to :resident
  has_one :handle, dependent: :destroy
  has_many :faileds, dependent: :destroy
  has_many :comments, dependent: :destroy

  # refileのための記述
  attachment :image

  # バリデーション
  with_options presence: true do
    validates :resident_id
    validates :latitude
    validates :longitude
    validates :detail, length: { minimum: 50 }
  end

  Geocoder.configure(language: :ja)
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

end
