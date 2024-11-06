# frozen_string_literal: true

class EventRepository
  def self.by_user_id(user_id:)
    Event.where(user_id:).order(initiated_at: :asc).to_a
  end
end
