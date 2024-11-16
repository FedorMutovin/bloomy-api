class UpdateEventsToVersion5 < ActiveRecord::Migration[7.2]
  def change
    update_view :events, version: 5, revert_to_version: 4
  end
end
