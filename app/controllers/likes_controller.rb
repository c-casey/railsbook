class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    @likeable = @like.likeable

    respond_to do |format|
      format.html { redirect_to @like.likeable }
      format.turbo_stream
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @like.likeable, status: :see_other }
      format.turbo_stream
    end
  end

  private

  def like_params
    { likeable_id: params[:likeable_id],
      likeable_type: params[:likeable_type],
      author_id: current_user.id }
  end
end
