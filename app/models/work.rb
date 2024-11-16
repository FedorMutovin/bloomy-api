# frozen_string_literal: true

class Work < ApplicationRecord
  include Relatable
  belongs_to :user
  has_one :work_load, dependent: :destroy
end
