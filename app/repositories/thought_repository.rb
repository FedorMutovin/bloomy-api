# frozen_string_literal: true

class ThoughtRepository
  def self.by_user_id(user_id:)
    Thought.where(user_id:).order(initiated_at: :desc).to_a
  end

  def self.add(**params)
    Thought.create!(**params)
  end
end
