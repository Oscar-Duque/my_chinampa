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

  def new
    @user_plant = UserPlant.new
    @api_plant = Plant.find(params[:plant_id])
    authorize(@user_plant)
  end

  def create
    @user = current_user
    @api_plant = Plant.find(params[:plant_id])
    @user_plant = UserPlant.new(user_plant_params)
    @user_plant.plant = @api_plant
    @user_plant.user = current_user
    authorize(@user_plant)
    if @user_plant.save
      flash[:notice] = "Your new plant was added to your collection"
      redirect_to user_plant_path(@user_plant)
    else
      render :new
    end
  end

  private

  def user_plant_params
    params.require(:user_plant).permit(:nickname, :photo, :plant_id)
  end

end
