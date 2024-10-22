# frozen_string_literal: true

class Vacation < ApplicationRecord
  include Relatable
  belongs_to :user
  has_many :travels, dependent: :destroy
end
