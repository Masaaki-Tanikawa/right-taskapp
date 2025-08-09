class BoardsController < ApplicationController
  before_action :set_board, only: [ :edit, :update ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

def index
  @q = Board.ransack(params[:q])
  @q.sorts = 'created_at asc' if @q.sorts.blank?
  @boards = @q.result.includes(:user, :cards)
end


	def show
		@board = Board.find(params[:id])
		@q = @board.cards.includes(user: :profile).ransack(params[:q])
		@cards = @q.result
	end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to board_path(@board), notice: "\u4FDD\u5B58\u3067\u304D\u307E\u3057\u305F"
    else
      flash.now[:error] = "\u4FDD\u5B58\u306B\u5931\u6557\u3057\u307E\u3057\u305F"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), notice: "\u66F4\u65B0\u3067\u304D\u307E\u3057\u305F"
    else
      flash.now[:error] = "\u66F4\u65B0\u306B\u5931\u6557\u3057\u307E\u3057\u305F"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to boards_path, status: :see_other, notice: "\u524A\u9664\u306B\u6210\u529F\u3057\u307E\u3057\u305F"
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :description)
  end
end
