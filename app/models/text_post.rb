class TextPost < ApplicationRecord
  validates :content, length: { in: 0..500 }

  has_many :posts, as: :postable, dependent: :destroy
end
