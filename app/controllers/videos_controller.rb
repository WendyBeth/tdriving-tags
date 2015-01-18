class VideosController < ApplicationController
  before_filter :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = Video.all
  end

  def show
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to video_path(@video)
    else
      render 'new', id: @video
    end
  end

  def edit
  end

  def update
    if @video.update_attributes(video_params)
      redirect_to video_path(@video)
    else
      render 'edit', id: @video
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_path
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :abstract, :youtube_code, :all_tags)
  end
end
