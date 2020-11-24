class UserPlantsController < ApplicationController

  def index
    @user_plants = UserPlant.all
  end

  private

  def article_params
    params.require(:user_plant).permit(:nickname, :photo)
  end

end
