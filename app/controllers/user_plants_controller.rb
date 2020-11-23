class UserPlantsController < ApplicationController


  private

  def article_params
    params.require(:user_plant).permit(:nickname, :photo)
  end

end
