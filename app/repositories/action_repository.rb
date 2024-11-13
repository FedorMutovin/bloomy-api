# frozen_string_literal: true

class ActionRepository
  def self.by_user_id(user_id:)
    Action.where(user_id:).order(initiated_at: :desc).to_a
  end

  def self.add(**params)
    Action.create!(**params)
  end
end
