# frozen_string_literal: true

module Roots
  class UniteRepository
    def self.unite(**params)
      Roots::Unite.create!(**params)
    end
  end
end
