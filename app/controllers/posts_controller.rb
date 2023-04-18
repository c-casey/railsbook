class PostsController < ApplicationController
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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
