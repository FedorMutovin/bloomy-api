# frozen_string_literal: true

module Unitable
  extend ActiveSupport::Concern

  included do
    has_one :unite_root, as: :source, class_name: 'Roots::Unite', dependent: :destroy
    has_many :unites, as: :target, class_name: 'Roots::Unite', dependent: :destroy
  end
end
