# frozen_string_literal: true

class WishSerializer < Panko::Serializer
  attributes :id, :title, :description, :priority, :initiated_at
end
