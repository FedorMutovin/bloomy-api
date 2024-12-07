# frozen_string_literal: true

class WishRepository
  class << self
    def by_user_id(user_id)
      Wish.where(user_id:, activated_at: nil).order(priority: :asc).to_a
    end

    def add(**params)
      Wish.create!(params)
    end

    def by_id(id)
      Wish.find(id)
    end

    def update(id, **params)
      Wish.find(id).update(params)
    end
  end
end
