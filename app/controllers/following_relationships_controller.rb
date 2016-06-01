class FollowingRelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    @user = User.friendly.find(params[:user_id])
    fr = current_user.following_relationships.build(followed_id: @user.id)
    if fr.save
      render json: fr
    else
      render json: {errors: fr.errors.full_messages}, status: 422
    end
  end

  def show
    @following_relationship = FollowingRelationship.find(params[:id])
  end

  def destroy
    current_user.following_relationships.find(params[:id]).destroy
    head :no_content
  end
end
