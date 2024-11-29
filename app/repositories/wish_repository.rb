# frozen_string_literal: true

class WishRepository
  def self.by_user_id(user_id:)
    Wish.where(user_id:, activated_at: nil).order(priority: :asc).to_a
  end

  def self.add(**params)
    Wish.create!(**params)
  end

  def self.by_id(id:)
    Wish.find(id)
  end

  def self.update(id, **params)
    Wish.find(id).update!(**params)
  end
end
