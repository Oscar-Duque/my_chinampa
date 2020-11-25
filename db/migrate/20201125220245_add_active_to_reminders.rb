class AddActiveToReminders < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :active, :boolean, default: true, null: false
  end
end
