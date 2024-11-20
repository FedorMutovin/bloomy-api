# frozen_string_literal: true

class Task < ApplicationRecord
  include Relatable
  include Scheduable
  include Reflectable

  belongs_to :user
  has_one :engagement, class_name: 'TaskEngagement', dependent: :destroy
end
