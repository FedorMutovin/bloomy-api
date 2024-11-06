class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, null: false
      t.string :name, null: false
      t.string :rating, null: false
      t.datetime :completed_at
      t.string :status, null: false

      t.timestamps
    end
  end
end
