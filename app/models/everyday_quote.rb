# frozen_string_literal: true

class EverydayQuote < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
end
