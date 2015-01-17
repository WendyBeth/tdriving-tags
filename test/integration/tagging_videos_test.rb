require "test_helper"

class TaggingVideosTest < ActionDispatch::IntegrationTest
  before :each do 
    DatabaseCleaner.start
  end

  after :each do 
    if page.has_content?('Sign out')
      click_link 'Sign out'
    end

    DatabaseCleaner.clean 
  end
end