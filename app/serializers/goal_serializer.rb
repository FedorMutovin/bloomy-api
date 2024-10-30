# frozen_string_literal: true

class GoalSerializer < Panko::Serializer
  attributes :id, :name, :created_at, :status, :started_at, :closed, :closed_at
  has_many :tasks, each_serializer: TaskSerializer

  def created_at
    object.created_at.strftime('%d-%m-%Y %H:%M')
  end

  def started_at
    object.started_at.strftime('%d-%m-%Y %H:%M') if object.started_at.present?
  end
end
