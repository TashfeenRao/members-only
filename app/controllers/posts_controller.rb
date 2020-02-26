class PostsController < ApplicationController
  before_action :check_log_in, only: %i[new create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = 'Successfully create post.'
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
