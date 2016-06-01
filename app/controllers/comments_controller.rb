class CommentsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      render json: @comment.to_json(include: :user)
    else
      render json: @comment.to_json(include: :user)
    end
  end

  def destroy
    current_user.comments.find(params[:id]).destroy
    head :no_content
  end

  def index
    @comments = Post.find(params[:post_id]).comments.page(params[:page]).per(20)
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
