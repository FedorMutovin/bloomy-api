# frozen_string_literal: true

class Thought < ApplicationRecord
  include Relatable
  include Reflectable
  belongs_to :user

  validates :description, :initiated_at, presence: true
end
