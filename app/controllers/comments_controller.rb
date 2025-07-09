class CommentsController < ApplicationController
  def new
    @card = Card.find(params[:card_id])
    @board = @card.board
    @comment = @card.comments.build
  end

  def create
    @card = Card.find(params[:card_id])
    @board = @card.board
    @comment = @card.comments.build(comment_params)
		@comment.user = current_user

    if @comment.save
      redirect_to board_card_path(@board, @card), notice: 'コメントを追加しました'
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
