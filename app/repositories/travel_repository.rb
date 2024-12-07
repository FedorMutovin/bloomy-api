# frozen_string_literal: true

class TravelRepository
  class << self
    def by_user_id(user_id)
      Travel.where(user_id:).order(initiated_at: :desc).to_a
    end

    def add(**params)
      Travel.create!(params)
    end

    def update(id, **params)
      Travel.find(id).update(params)
    end
  end
end
