# frozen_string_literal: true

class Vacation < ApplicationRecord
  include Relatable
  include Scheduable
  belongs_to :user
  has_many :travels, dependent: :destroy
end
