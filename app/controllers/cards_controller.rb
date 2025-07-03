class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @cards = card.all
  end

  def show
  end

  def new
    @card = current_user.cards.build
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      redirect_to card_path(@card), notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to card_path(@card), notice: '更新できました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    card = current_user.cards.find(params[:id])
    card.destroy!
    redirect_to cards_path, status: :see_other, notice: '削除に成功しました'
  end

  private

  def set_card
    @card = card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :description)
  end

end
