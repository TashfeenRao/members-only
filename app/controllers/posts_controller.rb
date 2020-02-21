class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id =
    if @post.save

    else
      render 'new'
    end


  end

  def index

  end

  private
    def post_params
      params.require(:post).permit(:title,:body,:user_id)
    end
end
