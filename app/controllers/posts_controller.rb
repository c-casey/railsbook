class PostsController < ApplicationController
  respond_to :html, :turbo_stream

  def index
    @friends = current_user.friends
    @posts = Post.relevant(current_user).ordered
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
