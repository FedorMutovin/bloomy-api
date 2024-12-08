# frozen_string_literal: true

class WorkRepository
  class << self
    def by_user_id(user_id)
      Work.where(user_id:).to_a
    end

    def add(**params)
      Work.create!(params)
    end

    def update(id, **params)
      Work.find(id).update(params)
    end
  end
end
