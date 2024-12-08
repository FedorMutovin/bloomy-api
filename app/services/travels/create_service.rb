# frozen_string_literal: true

module Travels
  class CreateService < Roots::CreateService
    private

    def create_root!
      TravelRepository.add(
        user_id: params[:user_id],
        description: params[:description],
        destination: params[:destination],
        initiated_at: params[:initiated_at],
        start_at: params[:start_at],
        end_at: params[:end_at]
      )
    end

    def after_create(root)
      super
      add_departure_schedule(root)
      add_return_schedule(root)
    end

    def add_departure_schedule(travel)
      Roots::ScheduleRepository.add(
        scheduable_id: travel.id,
        scheduable_type: travel.class.name,
        scheduled_at: travel.start_at,
        user_id: travel.user_id,
        details: { destination: travel.destination }
      )
    end

    def add_return_schedule(travel)
      Roots::ScheduleRepository.add(
        scheduable_id: travel.id,
        scheduable_type: travel.class.name,
        scheduled_at: travel.end_at,
        user_id: travel.user_id,
        details: { destination: 'Home' }
      )
    end
  end
end
