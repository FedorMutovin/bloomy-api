# frozen_string_literal: true

class DecisionRepository
  def self.by_user_id(user_id:)
    Decision.where(user_id:).order(initiated_at: :desc).to_a
  end

  def self.add(**params)
    Decision.create!(**params)
  end
end
