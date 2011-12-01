class AddLocationIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :location_id, :int
  end
end
