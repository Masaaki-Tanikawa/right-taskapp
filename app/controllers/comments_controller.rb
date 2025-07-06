class CommentsController < ApplicationController
  def new
    card = Card.find(params[:card_id])
    @comment = card.comments.build
  end

  def create
    card = Card.find(params[:card_id])
    @comment = card.comments.build(comment_params)
    if @comment.save
      redirect_to board_card_path(card), notice: 'コメントを追加'
		else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
	end
end