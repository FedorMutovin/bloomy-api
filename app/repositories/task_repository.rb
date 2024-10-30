# frozen_string_literal: true

class TaskRepository
  def self.by_user_id(user_id:)
    Task.where(user_id:).to_a
  end
end
