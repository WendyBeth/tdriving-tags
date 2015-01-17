class Admin::TagsController < ApplicationController
  before_filter :authenticate_admin!
  
  def index
    @tags = Tag.all
  end
end
