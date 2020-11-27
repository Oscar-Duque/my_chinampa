class UserPlantsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "nickname ILIKE :query"
      @user_plants = policy_scope(UserPlant.where(sql_query, query: "%#{params[:query]}%"))
    else
      @user_plants = policy_scope(UserPlant)
    end
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
