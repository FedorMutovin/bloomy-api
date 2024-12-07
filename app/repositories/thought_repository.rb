# frozen_string_literal: true

class ThoughtRepository
  class << self
    def by_user_id(user_id)
      Thought.where(user_id:).order(initiated_at: :desc).to_a
    end

    def add(**params)
      Thought.create!(params)
    end

    def update(id, **params)
      Thought.find(id).update(params)
    end
  end
end
