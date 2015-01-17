class Video < ActiveRecord::Base
  has_many :taggings
  has_many :tags, :through => :taggings
  
  validates :title, presence: true, uniqueness: true
end