# frozen_string_literal: true

class TaskRepository
  class << self
    def by_user_id(user_id)
      Task.where(user_id:, closed_at: nil, postponed_at: nil).order(priority: :asc).to_a
    end

    def add(**params)
      Task.create!(params)
    end

    def by_id(id)
      Task.find(id)
    end

    def ready_to_unpostpone
      Task.where(postponed_until: ..DateTime.current).to_a
    end

    def update(id, **params)
      Task.find(id).update(params)
    end

    def update_all(*ids, **params)
      ids.flatten.in_groups_of(1000, false) do |batch_ids|
        Task.where(id: batch_ids).update_all(params)
      end
    end
  end
end
