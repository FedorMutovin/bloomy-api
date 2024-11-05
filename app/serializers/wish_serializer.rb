# frozen_string_literal: true

class WishSerializer < Panko::Serializer
  attributes :id, :name, :description, :priority, :initiated_at
end
