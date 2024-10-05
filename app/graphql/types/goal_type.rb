# frozen_string_literal: true

module Types
  class GoalType < Types::BaseObject
    description "Represents a user's goal with basic information"

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false,
                                                        description: 'Date and time when the goal was created'
    field :id, ID, null: false, description: 'Unique identifier of the goal'
    field :name, String, null: false, description: 'Name of the goal'
  end
end
