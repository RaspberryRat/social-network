class ImagePost < ApplicationRecord
  has_one_attached :image

  has_many :posts, as: :postable, dependent: :destroy
end
