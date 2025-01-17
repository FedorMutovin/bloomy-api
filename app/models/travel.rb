# frozen_string_literal: true

class Travel < ApplicationRecord
  include Relatable
  include Scheduable
  belongs_to :user
  belongs_to :vacation, optional: true

  validates :destination, :initiated_at, presence: true
end
