# frozen_string_literal: true

class Action < ApplicationRecord
  include Relatable
  include Reflectable
  belongs_to :user

  validates :name, :initiated_at, presence: true
end
