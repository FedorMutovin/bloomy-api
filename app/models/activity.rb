# frozen_string_literal: true

class Activity < ApplicationRecord
  include Relatable
  belongs_to :user
  validates :name, :initiated_at, presence: true
end
