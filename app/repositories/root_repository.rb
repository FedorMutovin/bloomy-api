# frozen_string_literal: true

class RootRepository
  class << self
    def by_user_id(user_id)
      Root.where(user_id:).order(initiated_at: :desc).to_a
    end

    def available_types
      Root::AVAILABLE_TYPES
    end
  end
end
