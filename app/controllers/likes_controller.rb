class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    @post = @like.parent

    respond_to do |format|
      format.html { redirect_to @like.parent }
      format.turbo_stream
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.parent
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @like.parent, status: :see_other }
      format.turbo_stream
    end
  end

  private

  def like_params
    { parent_id: params[:post_id], author_id: current_user.id }
  end
end
