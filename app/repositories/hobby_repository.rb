# frozen_string_literal: true

class HobbyRepository
  def self.by_user_id(user_id:)
    Hobby.where(user_id:).order(initiated_at: :desc).to_a
  end

  def self.add(**params)
    Hobby.create!(**params)
  end
end
