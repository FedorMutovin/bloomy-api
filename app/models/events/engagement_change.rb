# frozen_string_literal: true

module Events
  class EngagementChange < ApplicationRecord
    self.table_name = :event_engagement_changes

    include Reflectable

    belongs_to :target, polymorphic: true
    validates :value, :reason, presence: true
  end
end
