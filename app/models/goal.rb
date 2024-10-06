# frozen_string_literal: true

class Goal < ApplicationRecord
  include Relatable
  has_many :actions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
