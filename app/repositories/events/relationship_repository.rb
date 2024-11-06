# frozen_string_literal: true

module Events
  class RelationshipRepository
    def self.add(trigger_id:, trigger_type:, target_id:, target_type:)
      Events::Relationship.create!(triggerable_id: trigger_id,
                                   triggerable_type: trigger_type,
                                   impactable_id: target_id,
                                   impactable_type: target_type)
    end

    def self.find_trigger_by_id(trigger_id:)
      Events::Relationship.find_by(triggerable_id: trigger_id).triggerable
    end
  end
end
