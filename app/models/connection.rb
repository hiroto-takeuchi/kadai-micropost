class Connection < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
end
