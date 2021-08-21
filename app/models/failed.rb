class Failed < ApplicationRecord
  # アソシエーション
  belongs_to :cat

  # バリデーション
  with_options presence: true do
    validates :cat_id
    validates :group_id
  end
  

end
