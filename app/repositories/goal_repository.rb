# frozen_string_literal: true

class GoalRepository
  def self.all
    Goal.all.to_a
  end

  def self.by_user_id(user_id:)
    Goal.where(user_id:).to_a
  end
end
