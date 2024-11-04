# frozen_string_literal: true

class GoalSerializer < Panko::Serializer
  attributes :id, :name, :description, :initiated_at, :status, :started_at, :closed_at, :priority
  has_many :tasks, each_serializer: TaskSerializer
end
