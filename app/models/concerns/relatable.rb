# frozen_string_literal: true

module Relatable
  extend ActiveSupport::Concern

  included do
    has_many :triggers, as: :triggerable, class_name: 'Events::Relationship', dependent: :destroy
    has_many :impacts, as: :impactable, class_name: 'Events::Relationship', dependent: :destroy
  end
end
