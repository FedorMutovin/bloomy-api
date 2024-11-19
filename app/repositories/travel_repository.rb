# frozen_string_literal: true

class TravelRepository
  def self.by_user_id(user_id:)
    Travel.where(user_id:).order(initiated_at: :desc).to_a
  end

  def self.add(**params)
    Travel.create!(**params)
  end
end
