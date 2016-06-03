class HashtagController < ApplicationController

  def show
    if params[:id].present?
      order = params[:order] == "popularity" ? "likes_count" : "id"
      @posts = Post.search(params[:id], order).page(params[:page]).per(12)
      puts @posts.records.first.inspect
      @posts.records

    else
      @posts = []
    end
  end
end
