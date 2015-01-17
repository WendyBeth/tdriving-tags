class Video < ActiveRecord::Base
  has_many :taggings
  validates :title, presence: true, uniqueness: true
end