# frozen_string_literal: true

class GoalRepository
  def self.by_user_id(user_id:)
    Goal.where(user_id:, closed_at: nil, postponed_at: nil).order(priority: :asc).to_a
  end

  def self.by_id(id:)
    Goal.find(id)
  end

  def self.add(params:)
    Goal.create!(params)
  end
end
