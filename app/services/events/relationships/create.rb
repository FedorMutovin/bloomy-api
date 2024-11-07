# frozen_string_literal: true

module Events
  module Relationships
    class Create
      def initialize(trigger_id:, trigger_type:, target_id:, target_type:)
        @trigger_id = trigger_id
        @trigger_type = trigger_type
        @target_id = target_id
        @target_type = target_type
      end

      def call
        create_relationship!
      end

      private

      attr_reader :trigger_id, :trigger_type, :target_id, :target_type

      def create_relationship!
        Events::RelationshipRepository.add(
          trigger_id:,
          trigger_type:,
          target_id:,
          target_type:
        )
      end
    end
  end
end
