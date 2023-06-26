class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:author)
  end

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.parent
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @post, status: :created }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @comment, status: :see_other }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.parent
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
