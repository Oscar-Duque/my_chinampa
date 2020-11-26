class RemindersController < ApplicationController

  def update
    @reminder = Reminder.find(params[:id])
    @reminder.update(reminder_params)
    authorize(@reminder)
    redirect_to user_plant_path(@reminder.user_plant)
  end

  private

  def reminder_params
    params.require(:reminder).permit(:start_date, :active)
  end
end
