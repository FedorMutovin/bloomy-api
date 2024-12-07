class AddNotNullInitiatedAtToMovies < ActiveRecord::Migration[7.2]
  def change
    change_column_null :movies, :initiated_at, false
  end
end
