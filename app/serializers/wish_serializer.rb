# frozen_string_literal: true

class WishSerializer < Panko::Serializer
  attributes :id, :title, :description

  def created_at
    object.created_at.strftime('%d-%m-%Y %H:%M')
  end
end
