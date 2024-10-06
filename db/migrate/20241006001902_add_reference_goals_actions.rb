class AddReferenceGoalsActions < ActiveRecord::Migration[7.2]
  def change
    add_reference :actions, :goal, type: :uuid, foreign_key: true
  end
end
