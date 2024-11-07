# frozen_string_literal: true

module EngagementChangable
  extend ActiveSupport::Concern

  included do
    has_many :engagement_changes, as: :target, class_name: 'Events::EngagementChange', dependent: :destroy
  end
end
