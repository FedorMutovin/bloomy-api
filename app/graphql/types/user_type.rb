# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    description 'A user in the system containing basic information and associated user experience'

    field :email, String, null: false, description: 'Email address of the user'
    field :goals, [Types::GoalType], null: false, description: 'List of goals associated with the user'
    field :id, ID, null: false, description: 'Unique identifier of the user'
  end
end
