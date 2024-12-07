# frozen_string_literal: true

class DecisionRepository
  class << self
    def by_user_id(user_id)
      Decision.where(user_id:).order(initiated_at: :desc).to_a
    end

    def add(**params)
      Decision.create!(params)
    end

    def update(id, **params)
      Decision.find(id).update(params)
    end
  end
end
