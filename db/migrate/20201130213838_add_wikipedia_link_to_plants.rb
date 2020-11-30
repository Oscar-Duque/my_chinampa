class AddWikipediaLinkToPlants < ActiveRecord::Migration[6.0]
  def change
    add_column :plants, :wikipedia_link, :string
  end
end
