# frozen_string_literal: true

class WorkLoad < ApplicationRecord
  MAX_LOAD_VALUE = 2
  MIN_LOAD_VALUE = 0

  belongs_to :work
  has_many :work_load_changes, dependent: :destroy
end
