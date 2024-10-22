# frozen_string_literal: true

class Wish < ApplicationRecord
  include Relatable

  belongs_to :user
  validates :title, presence: true
end
