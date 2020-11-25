class AddTypeToReminders < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :type, :string
  end
end
