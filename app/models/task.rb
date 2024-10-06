# frozen_string_literal: true

class Task < ApplicationRecord
  include Relatable
  has_many :actions, dependent: :destroy
  belongs_to :user
  belongs_to :goal, optional: true

  validates :name, presence: true
end
