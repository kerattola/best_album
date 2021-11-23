class ScoresController < ApplicationController
  def show
    @score= Score.find(params[:d])
  end
end
