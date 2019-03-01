class Micropost < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 10 }
  validates :content, presence: true, length: {maximum: 225 }
  
end
