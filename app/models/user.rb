# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :goals, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :decisions, dependent: :destroy
  has_many :hobbies, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
