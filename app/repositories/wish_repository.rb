# frozen_string_literal: true

class WishRepository
  def self.by_user_id(user_id:)
    Wish.where(user_id:).to_a
  end

  def self.add(params:, user_id:)
    Wish.create!(params.merge(user_id:))
  end
end
