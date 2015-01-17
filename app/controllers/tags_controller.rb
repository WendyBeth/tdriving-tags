class TagsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def show
    @tag = Tag.find(params[:id])
  end
  
  def new
    @video = Video.find(params[:video_id])
    @tag = @video.tags.build
  end

  def create
    @video = Video.find(params[:video_id])
    @tag = @video.tags.build(tag_params)

    if @tag.save
      redirect_to tag_path(@tag)
    else
      render 'new'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
