class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @board = Board.find(params[:board_id]) # URLのboard_idから対象のボードを取得
    @cards = @board.cards # そのボードに紐づく全カードを取得
  end

def show
  @board = Board.find(params[:board_id])
  @card = @board.cards.find(params[:id])
  @comments = @card.comments
end

  def new
    @board = Board.find(params[:board_id])  # URLのboard_idから対象のboardを取得
    @card = @board.cards.build  # boardに紐づけてカードを作成
  end

  def create
    @board = Board.find(params[:board_id])  # URLのboard_idから対象のboardを取得
    @card = @board.cards.build(card_params) # 取得したBoardに紐づく新しいCardを作成
    if @card.save
      redirect_to board_card_path(@board, @card), notice: '保存できました' # 保存後、ネストされたカードの詳細ページ /boards/:board_id/cards/:id にリダイレクト
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @card = Card.find(params[:id])
    @board = @card.board
  end

  def update
    @card = Card.find(params[:id])
    @board = @card.board
    if @card.update(card_params)
      redirect_to board_card_path(@board, @card), notice: '更新できました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:board_id]) # board を特定
    @card = @board.cards.find(params[:id]) # board に紐づく card を取得
    @card.destroy!
    redirect_to board_cards_path(@board), status: :see_other, notice: '削除に成功しました'
  end

  private

  def card_params
    params.require(:card).permit(:title, :description, :eyecatch)
  end
end
