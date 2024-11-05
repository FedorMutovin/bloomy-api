# frozen_string_literal: true

class Decision < ApplicationRecord
  include Relatable
  belongs_to :user
  validates :name, :initiated_at, presence: true
end
