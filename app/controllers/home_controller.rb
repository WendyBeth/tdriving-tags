class HomeController < ApplicationController
  def index
    gon.jbuilder :template => "app/views/tags/cloud.json.jbuilder", as: "tags"
  end
end