class UpdateEventsToVersion3 < ActiveRecord::Migration[7.2]
  def change
    update_view :events, version: 3, revert_to_version: 2
  end
end
