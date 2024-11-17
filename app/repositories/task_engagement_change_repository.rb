# frozen_string_literal: true

class TaskEngagementChangeRepository
  def self.add(**params)
    TaskEngagementChange.create!(**params)
  end
end
