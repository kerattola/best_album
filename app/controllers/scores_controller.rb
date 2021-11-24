class ScoresController < ApplicationController
  def index
    @scores= Score.all
  end

def new
    @score = Score.new
  end

  def create
    @score = Score.new(score_params)

    if @score.save
      redirect_to @scores
    else
      render :new
    end
  end

  private
    def score_params
      params.require(:score).permit(:number)
    end
end
