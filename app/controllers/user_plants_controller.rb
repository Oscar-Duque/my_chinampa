class UserPlantsController < ApplicationController
  def index
    @user_plants = policy_scope(UserPlant)
  end

  def new
    @user = current_user
    @user_plant = UserPlant.new
    authorize(@user_plant)
  end

  private

  def article_params
    params.require(:user_plant).permit(:nickname, :photo)
  end

end
