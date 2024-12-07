class CreateRoots < ActiveRecord::Migration[7.2]
  def change
    create_view :roots
  end
end
