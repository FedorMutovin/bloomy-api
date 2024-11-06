class ChangeNullForRatingMovies < ActiveRecord::Migration[7.2]
  def change
    change_column_null :movies, :rating, true
  end
end
