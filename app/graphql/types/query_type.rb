# frozen_string_literal: true

# rubocop:disable GraphQL/ObjectDescription
module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :user, Types::UserType, null: false do
      description 'Fetches a user object.'
      argument :id, ID, required: true, description: 'ID of the user.'
    end

    field :goals, [Types::GoalType], null: false, description: 'Returns a list of goals for a specific user.' do
      argument :user_id, ID, required: true, description: 'ID of the user whose goals are to be retrieved.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    def user(id:)
      UserRepository.by_id(id:)
    end

    def goals(user_id:)
      GoalRepository.by_user_id(user_id:)
    end
  end
end
# rubocop:enable GraphQL/ObjectDescription
