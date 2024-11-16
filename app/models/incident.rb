# frozen_string_literal: true

class Incident < ApplicationRecord
  MAX_IMPACT_VALUE = 2
  MIN_IMPACT_VALUE = 0

  include Relatable
  belongs_to :user
end
