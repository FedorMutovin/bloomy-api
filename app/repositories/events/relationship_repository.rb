# frozen_string_literal: true

module Events
  class RelationshipRepository
    def self.add(**params)
      Events::Relationship.create!(**params)
    end

    def self.find_trigger_by_id(trigger_id:)
      Events::Relationship.find_by(triggerable_id: trigger_id).triggerable
    end
  end
end
