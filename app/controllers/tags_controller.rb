class TagsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @tags = Tag.approved
  end

  def show
    @tag = Tag.find(params[:id])
    @videos = @tag.videos
  end
  
  def new
    @video = Video.find(params[:video_id])
    @tag = @video.tags.build
  end

  def create
    @video = Video.find(params[:video_id])
    @tag = Tag.find_or_create_by(name: tag_params[:name])
    tagging = @tag.taggings.build(tag_id: @tag.id, video_id: @video.id)

    if @tag.save && tagging.save
      redirect_to video_path(@video)
    else
      render 'new'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
