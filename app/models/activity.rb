# frozen_string_literal: true

class Activity < ApplicationRecord
  include Relatable
  belongs_to :user
  validates :name, presence: true
end
