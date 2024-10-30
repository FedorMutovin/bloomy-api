# frozen_string_literal: true

class GoalRepository
  def self.by_user_id(user_id:)
    Goal.where(user_id:, closed: false).order(priority: :asc).to_a
  end

  def self.by_id(id:)
    Goal.find(id)
  end
end
