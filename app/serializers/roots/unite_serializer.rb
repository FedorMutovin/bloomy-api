# frozen_string_literal: true

module Roots
  class UniteSerializer < Panko::Serializer
    attributes :id, :target_id, :target_type, :source_id, :source_type, :reason
  end
end
