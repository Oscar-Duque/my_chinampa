class RemindersController < ApplicationController
  def update
    @reminder = Reminder.find(params[:id])
    @reminder.update(reminder_params)
    redirect_to user_plant_path(@user_plant)
  end

  private

  def reminder_params
    params.require(:reminder).permit(:start_date, :active)
  end
end
