ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  Capybara.javascript_driver = :selenium

  def teardown
    Capybara.current_driver = nil
  end

  def sign_in_user
    visit new_user_session_path

    fill_in 'Email', with: users(:valid_user).email 
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  def sign_in_admin
    visit new_user_session_path

    fill_in 'Email', with: users(:admin_user).email
    fill_in 'Password', with: 'admin'
    click_button 'Log in'
  end
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection 
    @@shared_connection || retrieve_connection
  end
end

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection 

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end