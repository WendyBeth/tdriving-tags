class User < ActiveRecord::Base
  ADMIN = ['admin', 'member']

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    self.role && ADMIN.include?(self.role.downcase)
  end

  def self.admin_roles
    ADMIN.sort
  end
end