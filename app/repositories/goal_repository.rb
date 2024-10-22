# frozen_string_literal: true

class GoalRepository
  def self.by_user_id(user_id:)
    Goal.where(user_id:, closed: false).to_a
  end
end
