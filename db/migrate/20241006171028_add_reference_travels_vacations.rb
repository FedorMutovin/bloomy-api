class AddReferenceTravelsVacations < ActiveRecord::Migration[7.2]
  def change
    add_reference :travels, :vacation, foreign_key: true, type: :uuid
  end
end
