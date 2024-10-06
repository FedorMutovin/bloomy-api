# frozen_string_literal: true

module Scheduable
  extend ActiveSupport::Concern

  included do
    has_one :schedule, as: :scheduable, class_name: 'Event::Schedule', dependent: :destroy
  end
end
