class PlantsController < ApplicationController
  def index
    @user = current_user
    @user_plant = UserPlant.new
    if params[:query].present?
      @api_plants = Plant.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @api_plants = Plant.all.sample(30)
    end
  end
end
