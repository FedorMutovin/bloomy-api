# frozen_string_literal: true

class GoalRepository
  class << self
    def by_user_id(user_id)
      Goal.where(user_id:, closed_at: nil, postponed_at: nil)
          .where.not(status: Status::UNITED)
          .order(priority: :asc)
    end

    def by_id(id)
      Goal.find(id)
    end

    def add(**params)
      Goal.create!(params)
    end

    def update(id, **params)
      Goal.find(id).update(params)
    end
  end
end
