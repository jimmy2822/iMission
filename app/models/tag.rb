class Tag < ApplicationRecord
  has_many :taggings
  has_many :tasks, through: :taggings
end
