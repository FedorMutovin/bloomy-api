# frozen_string_literal: true

class Action < ApplicationRecord
  include Relatable
  belongs_to :task, optional: true
  belongs_to :goal, optional: true
  belongs_to :user
  validates :title, presence: true
end
