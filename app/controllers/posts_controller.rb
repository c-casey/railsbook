class PostsController < ApplicationController
  def index
    @friends = current_user.friends
    @posts = Post.relevant(current_user).ordered.includes([:author, { comments: [:author] }])
    @post = current_user.posts.build
  end

  def show
    @post = Post.find_by(id: params[:id])

    if @post.present?
      @comments = @post.comments.includes([:author])
      render :show
    else
      render file: "#{Rails.root}/public/404.html", layout: true, status: :not_found
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @new_post = current_user.posts.build

    if @post.save
      respond_to do |format|
        format.html { redirect_to @post, status: :see_other }
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
      respond_to do |format|
        format.html { redirect_to @post, status: :see_other }
        format.turbo_stream
      end
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
