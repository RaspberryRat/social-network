class TextPost < ApplicationRecord
  validates :content, length: { in: 1..500 }

  has_many :posts, as: :postable, dependent: :destroy
end
