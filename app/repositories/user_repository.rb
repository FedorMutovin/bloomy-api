# frozen_string_literal: true

class UserRepository
  def self.by_id(id:)
    User.find(id)
  end
end
