# frozen_string_literal: true

module Roots
  class RelationshipRepository
    def self.add(**params)
      Roots::Relationship.create!(**params)
    end

    def self.find_trigger_by_id(trigger_id:)
      Roots::Relationship.find_by(triggerable_id: trigger_id).triggerable
    end

    def self.by_user_id(user_id)
      Roots::Relationship.where(user_id:).to_a
    end
  end
end
