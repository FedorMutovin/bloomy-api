# frozen_string_literal: true

class TaskSerializer < Panko::Serializer
  attributes :id, :name, :description, :status, :priority, :initiated_at
end
