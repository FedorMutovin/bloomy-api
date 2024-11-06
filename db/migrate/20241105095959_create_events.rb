class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_view :events
  end
end
