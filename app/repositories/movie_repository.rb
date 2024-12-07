# frozen_string_literal: true

class MovieRepository
  class << self
    def by_user_id(user_id)
      Movie.where(user_id:).order(created_at: :desc).to_a
    end

    def add(**params)
      Movie.create!(params)
    end

    def update(id, **params)
      Movie.find(id).update(params)
    end
  end
end
