# frozen_string_literal: true

class ActionRepository
  class << self
    def by_user_id(user_id)
      Action.where(user_id:).order(initiated_at: :desc).to_a
    end

    def add(**params)
      Action.create!(params)
    end

    def update(id, **params)
      Action.find(id).update(params)
    end
  end
end
