class SearchController < ApplicationController

  def search
    if params[:id].present?
      @users = User.search(params[:id])
      render json: @users
    else
      @users = []
    end
  end
end
