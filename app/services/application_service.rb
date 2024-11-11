# frozen_string_literal: true

class ApplicationService
  extend Dry::Initializer[undefined: false]

  def self.call(...) = new(...).call

  def call
    raise NotImplementedError
  end
end
