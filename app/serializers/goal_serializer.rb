# frozen_string_literal: true

class GoalSerializer < Panko::Serializer
  attributes :id, :name, :created_at, :status, :started_at, :closed, :closed_at
end
