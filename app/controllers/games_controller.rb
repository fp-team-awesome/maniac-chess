class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params.merge(white_player_id: current_user.id))
    if @game.save!
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    begin 
      @game = Game.find(params[:id])
    rescue
      if @game.nil?
        render text: 'Game Not Found', status: :not_found
      end
    end
  end

  def update 
    @game = Game.find(params[:id])
    @game.update_attributes(current_user.id)
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
