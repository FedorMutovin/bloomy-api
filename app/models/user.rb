# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :goals, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :decisions, dependent: :destroy
  has_many :hobbies, dependent: :destroy
  has_many :thoughts, dependent: :destroy
  has_many :schedules, class_name: 'Event::Schedule', dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
