# frozen_string_literal: true

class MovieSerializer < Panko::Serializer
  attributes :id, :name, :status, :rating
end
