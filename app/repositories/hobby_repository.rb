# frozen_string_literal: true

class HobbyRepository
  class << self
    def by_user_id(user_id)
      Hobby.where(user_id:).order(initiated_at: :desc).to_a
    end

    def add(**params)
      Hobby.create!(params)
    end

    def update(id, **params)
      Hobby.find(id).update(params)
    end
  end
end
