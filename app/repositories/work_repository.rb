# frozen_string_literal: true

class WorkRepository
  def self.by_user_id(user_id:)
    Work.where(user_id:).to_a
  end

  def self.add(params:)
    Work.create!(params)
  end
end
