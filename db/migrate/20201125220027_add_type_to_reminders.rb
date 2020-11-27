class AddTypeToReminders < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :category, :integer
  end
end
