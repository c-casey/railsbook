class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    @post = @like.likeable

    respond_to do |format|
      format.html { redirect_to @like.likeable }
      format.turbo_stream
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.likeable
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @like.likeable, status: :see_other }
      format.turbo_stream
    end
  end

  private

  def like_params
    { likeable_id: params[:post_id], author_id: current_user.id }
  end
end
