# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :goals, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :decisions, dependent: :destroy
  has_many :hobbies, dependent: :destroy
  has_many :thoughts, dependent: :destroy
  has_many :schedules, class_name: 'Roots::Schedule', dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :movies, dependent: :destroy
  has_many :independent_events, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :roots_unites, class_name: 'Roots::Unite', dependent: :destroy
  has_many :relationships, class_name: 'Roots::Relationship', dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
