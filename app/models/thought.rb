# frozen_string_literal: true

class Thought < ApplicationRecord
  include Relatable
  belongs_to :user

  validates :description, presence: true
end
