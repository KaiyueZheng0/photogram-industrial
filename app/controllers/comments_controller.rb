class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :photo_id)
  end
end
