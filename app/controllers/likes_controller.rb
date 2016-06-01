class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post: @post)
    if @like.save
      render json: @like
    else
      render :json => { :errors => @like.errors.full_messages }, :status => 422
    end
  end
end
