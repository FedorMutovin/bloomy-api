class DropViewEvents < ActiveRecord::Migration[7.2]
  def change
    drop_view :events
  end
end
