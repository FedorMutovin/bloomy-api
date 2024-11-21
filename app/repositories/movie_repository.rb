# frozen_string_literal: true

class MovieRepository
  def self.by_user_id(user_id:)
    Movie.where(user_id:).order(created_at: :desc).to_a
  end

  def self.add(**params)
    Movie.create!(**params)
  end
end
