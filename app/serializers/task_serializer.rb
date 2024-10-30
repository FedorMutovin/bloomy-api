# frozen_string_literal: true

class TaskSerializer < Panko::Serializer
  attributes :id, :name, :description, :status, :created_at

  def created_at
    object.created_at.strftime('%d-%m-%Y %H:%M')
  end
end
