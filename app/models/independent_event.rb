# frozen_string_literal: true

class IndependentEvent < ApplicationRecord
  include Relatable
  belongs_to :user

  validates :occurred_at, :name, presence: true
end
