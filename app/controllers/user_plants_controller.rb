class UserPlantsController < ApplicationController
  def index
    @user_plants = policy_scope(UserPlant)
  end

  def show
    @user_plant = UserPlant.find(params[:id])
    authorize(@user_plant)
  end

  private

  def article_params
    params.require(:user_plant).permit(:nickname, :photo)
  end

end
