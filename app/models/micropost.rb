class Micropost < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites
  has_many :gooded, through: :favorites, source: :user
  #has_many :reverses_of_favorites
  #has_many :gooded, through: :favorites, source: :user
end
