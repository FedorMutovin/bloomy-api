# frozen_string_literal: true

class Decision < ApplicationRecord
  include Relatable
  belongs_to :user
  validates :title, :initiated_at, presence: true
end
