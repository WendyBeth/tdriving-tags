class TagsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]
  
  def new
  end
end
