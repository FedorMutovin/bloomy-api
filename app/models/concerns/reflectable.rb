# frozen_string_literal: true

module Reflectable
  extend ActiveSupport::Concern

  included do
    has_many :reflections, as: :reflectable, class_name: 'Event::Reflection', dependent: :destroy
  end
end
