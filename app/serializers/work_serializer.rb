# frozen_string_literal: true

class WorkSerializer < Panko::Serializer
  attributes :id, :company_name, :position_name, :start_date, :end_date, :work_load

  def work_load
    object.work_load.value
  end
end
