class ImagePost < ApplicationRecord
  has_many :posts, as: :postable, dependent: :destroy
end
