class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :videos, :through => :taggings

  validates :name, presence: true

  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }
  scope :rejected, -> { where(status: 'rejected') }
end
