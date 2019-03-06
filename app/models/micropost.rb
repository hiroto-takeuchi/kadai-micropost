class Micropost < ApplicationRecord
  belongs_to :user
  
  has_many :connections
  # has_many :like_users, through: :connections, source: :user
  
  validates :title, presence: true, length: { maximum: 10 }
  validates :content, presence: true, length: {maximum: 225 }
  
end
