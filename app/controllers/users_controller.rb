class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:show, :posts]

  def show
    @user = User.friendly.find(params[:id])
  end

  def posts
    @user = User.friendly.find(params[:id])
    @posts = @user.posts.order("created_at DESC").page(params[:page]).per(12)
  end

  def following
    @user = User.friendly.find(params[:id])
    respond_with current_user.following_relationships.find_by_followed_id(@user.id)
  end

  def likes
    @user = User.friendly.find(params[:id])
    @posts = @user.liked_posts.order("created_at DESC").page(params[:page]).per(12)
  end

  def followers
    @user = User.friendly.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20)
    respond_with @users, only: [:id, :bio, :username, :slug, :avatar]
  end

  def followed_users
    @user = User.friendly.find(params[:id])
    @users = @user.followed_users.page(params[:page]).per(20)
    respond_with @users, only: [:id, :bio, :username, :slug, :avatar]
  end

  def feed
    @posts = current_user.feed.order("created_at DESC").page(params[:page]).per(12)
  end


end
