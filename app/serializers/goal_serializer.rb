# frozen_string_literal: true

class GoalSerializer < Panko::Serializer
  attributes :id, :name, :created_at, :status, :started_at, :closed, :closed_at, :priority
  has_many :tasks, each_serializer: TaskSerializer
end
