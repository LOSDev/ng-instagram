class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    respond_with Post.all
  end

  def create
    respond_with Post.create(post_params.merge(user_id: current_user.id))
  end

  def show
    @post = Post.find(params[:id])
    if user_signed_in?
      @like = !!current_user.likes.find_by_post_id(@post.id)
    else
      @like = false
    end
  end

  def update
    post = current_user.posts.find(params[:id])
    post.update(description: params[:description])

    respond_with post
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    head :no_content
  end

  def like
    @like = Like.find_by(post_id: params[:id], user_id: current_user.id)
    render json: @like
  end

  def unlike
    @like = Like.find_by(post_id: params[:id], user_id: current_user.id).destroy
    head :no_content
  end





  private
  def post_params
    params.require(:post).permit(:description, :image)
  end
end
