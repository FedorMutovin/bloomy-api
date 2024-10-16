# frozen_string_literal: true

class Action < ApplicationRecord
  include Relatable
  include Reflectable
  belongs_to :task, optional: true
  belongs_to :goal, optional: true
  belongs_to :user
  has_many :repeats, dependent: :destroy
  validates :title, presence: true
end
