class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.date :start_date
      t.references :user_plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
