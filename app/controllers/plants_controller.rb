class PlantsController < ApplicationController
  def index
    @user = current_user
    @user_plant = UserPlant.new
    if params[:query].present?
      @api_plants = Plant.where('name ILIKE ?', "%#{params[:query]}%")
    else
      # @api_plants = Plant.all.shuffle
      good_plants = ["Garden tomato", "Wood anemone", "Lapland cornel", "European columbine", "Primrose", "European ash", "Spatulaleaf loosestrife", "European honeysuckle", "Robert geranium"]
      @api_plants = Plant.all.sample(30)
      good_plants.each do |plant_name|
        if Plant.where(name: plant_name).exists?
          plant = Plant.find_by(name: plant_name)
          @api_plants.unshift(plant)
        end
      end
    end
  end
end
